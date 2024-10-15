//
//  TasksLink.swift
//  Task-App
//
//  Created by Simone Samardzhiev on 12.10.24.
//

import SwiftUI


/// Button to go to uncompleted task list view.
struct TasksLink: View {
    /// Task view model.
    @Environment(TaskViewModel.self) var taskViewModel
    /// The type of the tasks the link will go to.
    let taskType: TaskType
    
    /// Default initializer.
    /// - Parameters:
    ///   - taskType: The type of the tasks the link will go to.
    init(taskType: TaskType) {
        self.taskType = taskType
    }
    
    var body: some View {
        NavigationLink {
            TasksListView(taskType)
                .environment(taskViewModel)
        } label: {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.accentColor)
                .frame(height: 100)
                .overlay(alignment: .topLeading) {
                    Image(systemName: systemImageName())
                        .padding()
                        .font(.title)
                }
                .overlay(alignment: .bottomLeading) {
                    Text(taskType.rawValue)
                        .padding()
                        .font(.title3)
                }
                .overlay(alignment: .topTrailing) {
                    Text(String(taskViewModel.getTasksByType(taskType).count))
                        .padding()
                        .font(.title)
                }
                .padding(CGFloat.paddingValue)
        }
        .foregroundStyle(Color.primary)
    }
    
    private func systemImageName() -> String {
        return switch taskType {
        case .uncompleted:
            "archivebox"
        case .completed:
            "checkmark.rectangle.stack"
        case .deleted:
            "trash"
        }
    }
}
