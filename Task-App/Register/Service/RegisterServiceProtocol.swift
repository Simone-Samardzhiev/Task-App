//
//  RegisterServiceProtocol.swift
//  Task-App
//
//  Created by Simone Samardzhiev on 9.10.24.
//

import Foundation


/// Protocol used to define the requirements for register service.
///
/// The protocol define property for encoding json data.
/// It also define method used to login the user.
protocol RegisterServiceProtocol {
    // MARK: Properties
    
    var encoder: JSONEncoder { get }
    
    // MARK: Methods
    
    /// Method that will register a user.
    ///
    /// The method will send the user email and password to the server.
    /// If the registration was successful it won't thrown an error.
    /// 
    /// - Parameters:
    ///   - email: The email of the user.
    ///   - password: The password of the user.
    func register(email: String, password: String) async throws
}
