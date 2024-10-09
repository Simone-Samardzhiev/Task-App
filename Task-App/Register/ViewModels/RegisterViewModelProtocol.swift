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
}
