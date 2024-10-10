//
//  LoginViewModelProtocol.swift
//  Task-App
//
//  Created by Simone Samardzhiev on 8.10.24.
//

import Foundation

/// Protocol used to define the requirements for login view model.
///
/// The protocol define necessary properties for storing the email and the password.
/// It also define the necessary property that hold the service used to login.
protocol LoginViewModelProtocol {
    /// The email of the user.
    var email: String { get }
    /// The password of the user.
    var password: String { get }
    /// Variable representing the login state.
    var state: ProgressState { get }
    /// Variable storing the JWT.
    var token: String? { get }
    /// Service used to login.
    var service: LoginServiceProtocol { get }
    
    // MARK: Methods
    /// Method that will reset the values of email and password
    func resetValues()
    
    /// Method that will change the state with animation.
    /// - Parameter newState: The new state.
    func changeState(_ newState: ProgressState)
    
    /// Method that will login the user.
    /// 
    /// It will send the data using the service
    /// and handle errors that may be thrown by updating the ui.
    /// - Returns: Returns the token send by the server.
    func login() async
    
    /// Method that will handle login error.
    ///
    /// It will update the UI based on the error type.
    ///
    /// - Parameter error: The error that was thrown.
    func handleLoginError(_ error: LoginError)
    
    /// Method that will handle any unknown error.
    /// - Parameter error: The error that was thrown.
    ///
    /// It will update the UI based on the error.
    func handleUnknownError(_ error: Error)
}
