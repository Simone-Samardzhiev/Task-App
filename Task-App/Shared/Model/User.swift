//
//  User.swift
//  Task-App
//
//  Created by Simone Samardzhiev on 9.10.24.
//

import Foundation


/// Struct used to create a user.
struct User: Codable {
    /// The email of the user.
    let email: String
    /// The password of the user.
    let password: String
}
