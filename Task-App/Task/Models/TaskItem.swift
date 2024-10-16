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
    /// The type of the task.
    var taskType: TaskType
    
    /// Enumeration with coding key used to encode the file.
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case priority
        case dueDate
        case dateDeleted
        case dateCompleted
    }
    
    /// Initializer from decoder.
    /// - Parameter decoder: Any decoder.
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(UUID.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.description = try container.decode(String.self, forKey: .description)
        self.priority = try container.decode(Priority.self, forKey: .priority)
        self.dueDate = try container.decode(Date.self, forKey: .dueDate)
        self.dateDeleted = try container.decodeIfPresent(Date.self, forKey: .dateDeleted)
        self.dateCompleted = try container.decodeIfPresent(Date.self, forKey: .dateCompleted)
        
        if dateDeleted != nil {
            self.taskType = .deleted
        } else if dateCompleted != nil {
            self.taskType = .completed
        } else {
            self.taskType = .uncompleted
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(description, forKey: .description)
        try container.encode(priority, forKey: .priority)
        try container.encode(dueDate, forKey: .dueDate)
        try container.encode(dateDeleted, forKey: .dateDeleted)
        try container.encode(dateCompleted, forKey: .dateCompleted)
    }
}
