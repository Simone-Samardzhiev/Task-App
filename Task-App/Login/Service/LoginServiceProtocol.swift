//
//  LoginServiceProtocol.swift
//  Task-App
//
//  Created by Simone Samardzhiev on 9.10.24.
//

import Foundation


/// A protocol that defines the requirements for a login service.
///
/// The protocol define necessary property for encoding json files.
/// It also provide a method used to login the user.
protocol LoginServiceProtocol {
    // MARK: Properties
    
    /// Property used to encode json data.
    var encoder: JSONEncoder {get}
    
    // MARK: Methods 
    
    /// Method that will login the user.
    ///
    /// It will send the email and the password to the server.
    /// If the the credentials are correct it will return JWT
    /// otherwise it will thrown an error.
    ///
    /// - Parameters:
    ///   - email: The email of the user.
    ///   - password: The password of the user.
    /// - Returns: The token returned by the server.
    func login(email: String, password: String) async throws -> String
}
