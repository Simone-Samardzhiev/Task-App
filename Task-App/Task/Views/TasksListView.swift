//
//  TasksListView.swift
//  Task-App
//
//  Created by Simone Samardzhiev on 12.10.24.
//

import SwiftUI


/// View that will show that uncompleted tasks.
struct TasksListView: View {
    /// Task view model.
    @Environment(TaskViewModel.self) var taskViewModel
    /// Variable used to set the type of tasks displayed.
    let taskType: TaskType
    
    /// Default initializer.
    /// - Parameter taskType: The task type that will be shown.
    init(_ taskType: TaskType) {
        self.taskType = taskType
    }
    
    var body: some View {
        @Bindable var taskViewModel = taskViewModel
        let tasks = taskViewModel.getTasksByType(taskType)
        
        List {
            ForEach(tasks, id: \.hashValue) { task in
                TaskWidget(task)
            }
            .onDelete { indexSet in
                onDelete(
                    indexSet: indexSet,
                    tasks: tasks
                )
            }
        }
        .overlay(alignment: .bottom) {
            ProgressWidget($taskViewModel.state)
        }
        .ignoresSafeArea(edges: .bottom)
        .navigationTitle(taskType.rawValue)
    }
    
    func onDelete(indexSet: IndexSet, tasks: [TaskItem]) {
        Task {
            await withTaskGroup(of: Void.self) { group in
                for index in indexSet {
                    group.addTask {
                        await taskViewModel.deleteTask(tasks[index])
                    }
                }
            }
        }
    }
}
