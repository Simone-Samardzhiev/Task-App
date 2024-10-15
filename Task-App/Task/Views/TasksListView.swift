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
        List {
            switch taskType {
            case .uncompleted:
                ForEach(taskViewModel.uncompletedTasks, id: \.hashValue) { task in
                    
                }
            case .completed:
                ForEach(taskViewModel.completedTasks, id: \.hashValue) { task in
                    
                }
            case .deleted:
                ForEach(taskViewModel.deletedTasks, id: \.hashValue) { task in
                }
            }
        }
        .navigationTitle(taskType.rawValue)
        .overlay(alignment: .bottom) {
            ProgressWidget($taskViewModel.state)
        }
    }
}
