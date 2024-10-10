
//  RegisterState.swift
//  Task-App
//
//  Created by Simone Samardzhiev on 10.10.24.
//

import SwiftUI


/// Enumeration representing the state of process
///
/// - idle: There is no process happening.
/// - processing: The process is active.
/// - success: The process finished successfully with a message.
/// - failure: The process failed to finish with a message.
enum ProgressState {
    case idle
    case processing(String)
    case success(String)
    case failure(String)
}
