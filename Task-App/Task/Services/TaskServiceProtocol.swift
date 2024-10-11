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
protocol TaskServiceProtocol: Actor {
    // MARK: Properties
    /// Property used to decode json data.
    var decoder: JSONDecoder { get }
    /// Property used to encode json data.
    var encoder: JSONEncoder { get }
    /// The JWT token that was received on login.
    var token: String { get }
    
    // MARK: Methods
    
    /// Method that will get all tasks of the user.
    ///
    /// The method will send a request to the server.
    /// It will parse the data that was checked and transform it to
    /// an array of task items. If there are not any errors it will return the array.
    ///
    /// - Returns: The tasks that where received.
    func getTasks() async throws -> [TaskItem]
    
    /// Method that will a new task.
    ///
    /// The method will send the new task to server to be added.
    /// If the method doesn't thrown an error it means the task was added successfully.
    ///
    /// - Parameter task: The new task that will be added.
    func addTask(_ task: NewTaskItem) async throws
    
    /// Method that will delete a task.
    ///
    /// The method will the task to the server to be deleted.
    /// If the method doesn't thrown any error it means that the task was deleted successfully.
    ///
    /// - Parameter task: The task that will be deleted.
    func deleteTask(_ task: TaskItem) async throws
    
    /// Method that will update a task information.
    ///
    /// The method will send the task to the server to be updated.
    /// If the method doesn't thrown any error the task was updated successfully.
    ///
    /// - Parameter task: The task that will be updated.
    func updateTask(_ task: TaskItem) async throws
    
    /// Method that will start a task that will refresh the token.
    func startRefreshingToken()
}
