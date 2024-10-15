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
    
    /// Array holding all the task.
    var tasks: [TaskItem] { get }
    /// Variable representing any tasks change state.
    var state: ProgressState { get }
    /// Variable representing if the task are already loaded.
    var taskLoaded: Bool { get }
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
    func getTasks() async
    
    /// Method that will add a new task.
    /// 
    /// The method will use the service to send a request to the server
    /// and update the UI based on the result.
    ///
    /// - Parameter task: The task that will be added.
    func addTask(_ task: NewTaskItem) async
    
    /// Method that will update an existing task.
    ///
    /// The method will send request to the server with the task
    /// and update the UI based on the result.
    ///
    /// - Parameter task: The task that will be updated.
    func updateTask(_ task: TaskItem) async
    
    /// Method that will delete a task.
    /// 
    /// The method will send request to the server with task
    /// and update the UI based on the result.
    /// 
    /// - Parameter indexSet: Index set of the tasks that will be deleted.
    func deleteTask(_ indexSet: IndexSet) async
    
    /// Method that will handle task error.
    /// - Parameter error: The error that was thrown.
    func handleTaskError(_ error: TaskError)
    
    /// Method that will handle unknown error.
    /// - Parameter error: The error that was thrown.
    func handleUnknownError(_ error: Error)
    
    /// Method that will change the state.
    /// - Parameter newState: Thew new state.
    func changeState(_ newState: ProgressState)
    
    /// Method that will start a task to refresh the JWT.
    func startRefreshTokenTask()
    
    /// Method that will stop the task that refresh the JWT.
    func stopRefreshTokenTask()
    
    /// Method that will filter the tasks by a type.
    /// - Parameter taskType: The type used to filter the tasks.
    /// - Returns: The tasks that have the same type.
    func getTasksByType(_ taskType: TaskType) -> [TaskItem]
}
