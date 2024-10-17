//
//  TaskWidget.swift
//  Task-App
//
//  Created by Simone Samardzhiev on 15.10.24.
//

import SwiftUI


/// Widget that will display the task in the list.
struct TaskWidget: View {
    /// Task view model
    @Environment(TaskViewModel.self) var taskViewModel
    /// Task that will be displayed.
    @State var task: TaskItem
    
    /// Default initializer.
    /// - Parameter task: The task that will be shown.
    init(_ task: TaskItem) {
        self.task = task
    }
    
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(taskColor())
                .frame(width: 5, height: 50)
            
            VStack(alignment: .leading) {
                Text(task.name)
                    .font(.headline)
                Text(task.description)
                    .font(.subheadline)
            }
            
            Spacer()
            
            if task.taskType == .uncompleted {
                VStack {
                    Text(task.dueDate.formatted(.dateTime.year().month().day()))
                        .font(.headline)
                    
                    Text(task.dueDate.formatted(.dateTime.hour().minute()))
                        .font(.subheadline)
                }
            }
        }
        .swipeActions(edge: .leading) {
            swipeActionView()
        }
    }
    
    /// Method that will return a color based on the task priority.
    /// - Returns: The color.
    private func taskColor() -> Color {
        return switch task.priority {
        case .low:
            Color.green
        case .medium:
            Color.yellow
        case .high:
            Color.orange
        case .vital:
            Color.red
        }
    }
    
    func swipeActionView() -> some View {
        Group {
            switch task.taskType {
            case .uncompleted:
                Button {
                    task.dateCompleted = Date()
                    task.taskType = .completed
                    Task {
                        await taskViewModel.updateTask(task)
                    }
                } label: {
                    Image(systemName: "checkmark.circle")
                        .foregroundStyle(Color.primary)
                }
                .tint(Color.accentColor)
            case .completed:
                Button {
                    task.dateCompleted = nil
                    task.taskType = .uncompleted
                    Task {
                        await taskViewModel.updateTask(task)
                    }
                } label: {
                    Image(systemName: "checkmark.circle.badge.xmark")
                        .foregroundStyle(Color.primary)
                }
                .tint(Color.accentColor)
            case .deleted:
                Button {
                    task.dateDeleted = nil
                    task.taskType = .uncompleted
                    Task {
                        await taskViewModel.updateTask(task)
                    }
                } label: {
                    Image(systemName: "trash.slash")
                        .foregroundStyle(Color.primary)
                }
                .tint(Color.accentColor)
            }
        }
    }
}
