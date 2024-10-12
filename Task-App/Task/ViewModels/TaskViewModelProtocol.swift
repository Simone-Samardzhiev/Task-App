//
//  TaskViewModelProtocol.swift
//  Task-App
//
//  Created by Simone Samardzhiev on 12.10.24.
//

import Foundation


/// Protocol that defines requirements for task view model.
///
/// It defines properties for storing the tasks, closing the view and a task that will refresh the token.
/// It also defines methods for getting, adding, updating and deleting tasks.
/// It also provide methods for starting and stoping the task that will refresh the token.
protocol TaskViewModelProtocol {
    // MARK: Properties
    /// Tasks that haven't been completed.
    var uncompletedTasks: [TaskItem] { get }
    /// Tasks that have been completed.
    var completedTasks: [TaskItem] { get }
    /// Tasks that have been deleted.
    var deletedTasks: [TaskItem] { get }
    /// Task that will refresh the token until the user exit.
    var refreshTokenTask: Task<Void, Error>? { get }
    /// Method that will close the task view and go back to login view with a state.
    var closeTaskView: (_ withState: ProgressState) -> Void { get }
    /// The service that will manage the tasks.
    var service: TaskServiceProtocol { get }
    
    // MARK: Methods
    
    /// Method that will get all the tasks of the user.
    ///
    /// The method will use the service to send a request to the server
    /// and update the UI based on the result
    func getTasks()
    
    /// Method that will add a new task.
    /// 
    /// The method will use the service to send a request to the server
    /// and update the UI based on the result.
    ///
    /// - Parameter task: The task that will be added.
    func addTask(_ task: NewTaskItem)
    
    /// Method that will update an existing task.
    ///
    /// The method will send request to the server with the task
    /// and update the UI based on the result.
    ///
    /// - Parameter task: The task that will be updated.
    func updateTask(_ task: TaskItem)
    
    /// Method that will delete a task.
    ///
    /// The method will send request to the server with task
    /// and update the UI based on the result.
    ///
    /// - Parameter task: The task that will be deleted.
    func deleteTask(_ task: TaskItem)
    
    /// Method that will start a task to refresh the JWT.
    func startRefreshTokenTask()
    
    /// Method that will stop the task that refresh the JWT.
    func stopRefreshTokenTask()
}
