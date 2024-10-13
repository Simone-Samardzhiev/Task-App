//
//  TaskView.swift
//  Task-App
//
//  Created by Simone Samardzhiev on 10.10.24.
//

import SwiftUI


/// View that will display the tasks.
struct TaskView: View {
    /// Task view model.
    let taskViewModel: TaskViewModel
    
    /// Default initializer.
    /// - Parameters:
    ///   - token: The token that was revived on login.
    ///   - closeTaskView: The method used to close task view.
    init(token: String, closeTaskView: @escaping (ProgressState) -> Void) {
        self.taskViewModel = TaskViewModel(closeTaskView: closeTaskView, service: TaskService(token))
    }
    
    var body: some View {
        VStack {
            
        }
    }
}
