
//  RegisterState.swift
//  Task-App
//
//  Created by Simone Samardzhiev on 10.10.24.
//

import SwiftUI


/// Enumeration representing the state of registering process
///
/// - idle: The user have not clicked the button to register.
/// - processing: The user is being registered.
/// - success: The user have been successfully registered
/// - failure: The user failed to registered with an error message.
enum RegisterState {
    case idle
    case processing
    case success
    case failure(String)
}
