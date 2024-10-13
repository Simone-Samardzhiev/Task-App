//
//  UncompletedTasksLink.swift
//  Task-App
//
//  Created by Simone Samardzhiev on 12.10.24.
//

import SwiftUI


/// Button to go to uncompleted task list view.
struct TasksLink: View {
    /// Task view model.
    @Environment(TaskViewModel.self) var taskViewModel
    
    var body: some View {
        NavigationLink {
            UncompletedTaskListView()
        } label: {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.accentColor)
                .frame(height: 100)
                .overlay(alignment: .topLeading) {
                    Image(systemName: "archivebox")
                        .padding()
                        .font(.title2)
                }
                .overlay(alignment: .bottomLeading) {
                    Text("Uncompleted tasks")
                        .padding()
                        .font(.title3)
                }
                .overlay(alignment: .topTrailing) {
                    Text(String(taskViewModel.uncompletedTasks.count))
                        .padding()
                        .font(.title)
                }
                .padding(CGFloat.paddingValue)
        }
        .foregroundStyle(Color.primary)
    }
}
