//
//  RegisterViewModelProtocol.swift
//  Task-App
//
//  Created by Simone Samardzhiev on 9.10.24.
//

import Foundation


/// Protocol used to define the requirements for register view model.
///
/// The protocol defines necessary properties for storing the email, password and confirm password.
/// It also provide methods to check if the email is valid and if the password is strong enough. 
protocol RegisterViewModelProtocol {
    // MARK: Properties
    
    /// Variable storing the email of the user.
    var email: String { get }
    /// Variable storing the password of the user.
    var password: String { get }
    /// Variable storing the second password used to confirm they are the same.
    var confirmPassword: String { get }
    /// Variable representing the registration state.
    var state: ProgressState { get set}
    /// Service used to register.
    var service: RegisterServiceProtocol { get }
    
    // MARK: Methods
    
    /// Method that will check if the email is valid.
    /// - Returns: True if the email is valid otherwise false.
    func checkEmail() -> Bool
    
    /// Method that will check if the password is strong enough.
    /// - Returns: True if the password is strong otherwise false.
    func checkPassword() -> Bool
    
    /// Method that will reset the values of the email, password and confirm password.
    func resetValues()
    
    /// Method that will register the user.
    ///
    /// It will used the service to send the data and handle the error
    /// that may be thrown to update the UI.
    func register() async
    
    /// Method that will handle all register error types.
    ///
    /// It will update the UI to handle based on the error type.
    ///
    /// - Parameter error: The error that was thrown
    func handleRegisterError(error: RegisterError)
    
    /// Method that will handle any unknown errors.
    ///
    /// It will update the user based on the error.
    ///
    /// - Parameter error: The error that was thrown.
    func handleUnknownError(error: Error)
}
