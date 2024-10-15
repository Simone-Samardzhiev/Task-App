//
//  NewTaskItem.swift
//  Task-App
//
//  Created by Simone Samardzhiev on 11.10.24.
//

import Foundation


/// Struct representing a task that was created.
///
/// It is used to send new tasks to the server.
struct NewTaskItem: Encodable {
    /// The name of the task.
    var name: String
    /// The description of the task.
    var description: String
    /// The priority of the task.
    var priority: Priority
    /// The date till the task has to be completed.
    var dueDate: Date
    
    init() {
        self.name = ""
        self.description = ""
        self.priority = .low
        self.dueDate = Date()
    }
}
