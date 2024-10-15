//
//  TaskViewModel.swift
//  Task-App
//
//  Created by Simone Samardzhiev on 12.10.24.
//

import Foundation
import SwiftUI

@Observable
class TaskViewModel: TaskViewModelProtocol {
    // MARK: Properties
    
    var uncompletedTasks: [TaskItem]
    var completedTasks: [TaskItem]
    var deletedTasks: [TaskItem]
    var state: ProgressState
    @ObservationIgnored var taskLoaded: Bool
    @ObservationIgnored var refreshTokenTask: Task<Void, any Error>?
    @ObservationIgnored let closeTaskView: (ProgressState) -> Void
    @ObservationIgnored let service: TaskServiceProtocol
    
    // MARK: Initializer
    
    init(closeTaskView: @escaping (ProgressState) -> Void, service: TaskServiceProtocol) {
        self.uncompletedTasks = []
        self.completedTasks = []
        self.deletedTasks = []
        self.state = .idle
        self.taskLoaded = false
        self.refreshTokenTask = nil
        self.closeTaskView = closeTaskView
        self.service = service
    }
    
    func getTasks() async {
        await MainActor.run {
            uncompletedTasks.removeAll()
            completedTasks.removeAll()
            deletedTasks.removeAll()
            changeState(.processing("Loading tasks"))
        }
        
        do {
            let tasks = try await service.getTasks()
            await MainActor.run {
                for task in tasks {
                    if task.dateDeleted != nil {
                        deletedTasks.append(task)
                    } else if task.dateCompleted != nil {
                        completedTasks.append(task)
                    } else {
                        uncompletedTasks.append(task)
                    }
                }
                
                changeState(.idle)
            }
        } catch let error as TaskError {
            await MainActor.run {
                handleTaskError(error)
            }
        } catch {
            await MainActor.run {
                handleUnknownError(error)
            }
        }
    }
    
    func addTask(_ task: NewTaskItem) async {
        await MainActor.run {
            changeState(.processing("Adding task"))
        }
        
        do {
            try await service.addTask(task)
            await getTasks()
            await MainActor.run {
                changeState(.success("Task added!"))
            }
        } catch let error as TaskError {
            await MainActor.run {
                handleTaskError(error)
            }
        } catch {
            await MainActor.run {
                handleUnknownError(error)
            }
        }
    }
    
    func updateTask(_ task: TaskItem) async {
        await MainActor.run {
            changeState(.processing("Updating task"))
        }
        
        do {
            try await service.updateTask(task)
            await MainActor.run {
                changeState(.success("Task updated!"))
            }
        } catch let error as TaskError {
            await MainActor.run {
                handleTaskError(error)
            }
        } catch {
            await MainActor.run {
                handleUnknownError(error)
            }
        }
    }
    
    func deleteTask(_ task: TaskItem) async {
        await MainActor.run {
            changeState(.processing("Deleting task"))
        }
        
        do {
            try await service.updateTask(task)
            await MainActor.run {
                changeState(.success("Task deleted!"))
            }
        } catch let error as TaskError {
            await MainActor.run {
                handleTaskError(error)
            }
        } catch {
            await MainActor.run {
                handleUnknownError(error)
            }
        }
    }
    
    func handleTaskError(_ error: TaskError) {
        switch error {
        case .notConnected:
            changeState(.failure("Check your connection!"))
        case .tokenExpired:
            closeTaskView(.failure("Token expired! Please login again!"))
        default:
            closeTaskView(.failure("There was an unknown error!"))
#if DEBUG
            print("Unknown error in task error: \(error)")
#endif
        }
    }
    
    func handleUnknownError(_ error: any Error) {
        closeTaskView(.failure("There was an unknown error!"))
#if DEBUG
        print("Unknown error\(error)")
#endif
    }
    
    func changeState(_ newState: ProgressState) {
        withAnimation {
            state = newState
        }
    }
    
    func startRefreshTokenTask() {
        refreshTokenTask = Task {
            try? await Task.sleep(for: .seconds(240))
            do {
                try await service.refreshToken()
            } catch let error as TaskError {
                await MainActor.run {
                    handleTaskError(error)
                }
            } catch {
                await MainActor.run {
                    handleUnknownError(error)
                }
            }
        }
    }
    
    func stopRefreshTokenTask() {
        refreshTokenTask?.cancel()
    }
}
