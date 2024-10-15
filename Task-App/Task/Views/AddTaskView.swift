//
//  AddTaskView.swift
//  Task-App
//
//  Created by Simone Samardzhiev on 15.10.24.
//

import SwiftUI


/// View used to add a task.
struct AddTaskView: View {
    /// Task view model.
    @Environment(TaskViewModel.self) var taskViewModel
    /// The task that will be added.
    @State var task = NewTaskItem()
    
    var body: some View {
        @Bindable var taskViewModel = taskViewModel
        GeometryReader { geometry in
            VStack(spacing: CGFloat.paddingValue) {
                textField("Name", text: $task.name)
                textField("Description", text: $task.description)
                priorityPicker()
                DatePicker("Pick the date", selection: $task.dueDate, in: Date()...)
                addButton()
                Spacer()
                ProgressWidget($taskViewModel.state)
            }
            .padding(.top, geometry.size.height / 3)
        }
        .ignoresSafeArea()
        .padding(.horizontal, CGFloat.paddingValue)
        .navigationTitle("Add task")
    }
    
    private func textField(_ title: String, text: Binding<String>) -> some View {
        return VStack {
            TextField(title, text: text)
            Rectangle()
                .frame(height: 1)
        }
    }
    
    private func priorityPicker() -> some View {
        return Picker("Pick priority", selection: $task.priority) {
            ForEach(Priority.allCases, id: \.hashValue) { priority in
                Text(priority.rawValue)
                    .tag(priority)
            }
        }
        .pickerStyle(.segmented)
    }
    
    
    private func addButton() -> Button<some View> {
        return Button {
            Task {
                await taskViewModel.addTask(task)
            }
        } label: {
            Text("Add task")
                .foregroundStyle(Color.primary)
                .font(.largeTitle)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 10)
                }
        }
    }
}
