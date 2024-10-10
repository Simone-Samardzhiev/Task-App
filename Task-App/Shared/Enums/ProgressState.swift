
//  ProgressState.swift
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
    
    /// Method that will check if the state is idle.
    /// - Returns: True if the state is idle otherwise false.
    func isIdle() -> Bool {
        if case .idle = self {
            return true
        }
        return false
    }
    
    /// Method that will check if the state is processing.
    /// - Returns: True if the state is processing otherwise false.
    func isProcessing() -> Bool {
        if case .processing = self {
            return true
        }
        return false
    }
    
    /// Method that will check if the state is success.
    /// - Returns: True if the state is success otherwise false.
    func isSuccess() -> Bool {
        if case .success = self {
            return true
        }
        return false
    }
    
    /// Method that will check if the state is failure.
    /// - Returns: True if the state if failure otherwise false.
    func isFailure() -> Bool {
        if case .failure = self {
            return true
        }
        return false
    }
}
