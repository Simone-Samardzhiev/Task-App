//
//  TaskItem.swift
//  Task-App
//
//  Created by Simone Samardzhiev on 11.10.24.
//

import Foundation


/// Struct representing a task.
///
/// It is used to parse the json data send by the server and also to
/// display it on the UI.
struct TaskItem: Codable, Hashable {
    /// The id of the task.
    let id: UUID
    /// The name of the task.
    var name: String
    /// The description of the task.
    var description: String
    /// The priority of the task.
    var priority: Priority
    /// The date till the task has to be completed.
    var dueDate: Date
    /// Date when the task was deleted.
    var dateDeleted: Date?
    /// Date when the task was completed.
    var dateCompleted: Date?
}
