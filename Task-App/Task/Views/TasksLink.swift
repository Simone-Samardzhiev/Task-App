//
//  TasksLink.swift
//  Task-App
//
//  Created by Simone Samardzhiev on 12.10.24.
//

import SwiftUI


/// Button to go to uncompleted task list view.
struct TasksLink<Destination: View>: View {
    /// Task view model.
    @Environment(TaskViewModel.self) var taskViewModel
    /// The destination of the link.
    let destination: () -> Destination
    /// The text displayed on the link.
    let text: String
    /// The image name that will be displayed.
    let imageName: String
    
    /// Default initializer.
    /// - Parameters:
    ///   - text: The text that will be displayed.
    ///   - imageName: The image that will be displayed.
    ///   - destination: The destination of the link.
    init(text: String, imageName: String, destination: @escaping () -> Destination) {
        self.text = text
        self.imageName = imageName
        self.destination = destination
    }
    
    var body: some View {
        NavigationLink {
            destination()
        } label: {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.accentColor)
                .frame(height: 100)
                .overlay(alignment: .topLeading) {
                    Image(systemName: imageName)
                        .padding()
                        .font(.title2)
                }
                .overlay(alignment: .bottomLeading) {
                    Text(text)
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
