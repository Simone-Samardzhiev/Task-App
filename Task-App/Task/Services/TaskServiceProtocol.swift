//
//  TaskServiceProtocol.swift
//  Task-App
//
//  Created by Simone Samardzhiev on 11.10.24.
//

import Foundation


/// Protocol that defines the requirements for Task service.
///
/// The protocol defines properties for encoding and decoding json files.
/// It also provide property that will store the JWT.
///
/// It defines method for getting, adding, deleting and updating a task.
protocol TaskServiceProtocol {
    var decoder: JSONDecoder { get }
    var encoder: JSONEncoder { get }
    var token: String { get }
    
    func getTasks() async throws -> [TaskItem]
    func addTask(_ task: NewTaskItem) async throws
    func deleteTask(_ task: TaskItem) async throws
    func updateTask(_ task: TaskItem) async throws
}
