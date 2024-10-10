//
//  LoginViewModel.swift
//  Task-App
//
//  Created by Simone Samardzhiev on 8.10.24.
//

import Foundation
import SwiftUI


/// View model that will manage the log in.
@Observable
class LoginViewModel: LoginViewModelProtocol {
    // MARK: Properties
    
    var email: String
    var password: String
    var state: ProgressState
    let service: LoginServiceProtocol
    
    // MARK: Initializer.
    
    init(service: LoginServiceProtocol) {
        self.email = ""
        self.password = ""
        self.state = .idle
        self.service = service
    }
    
    // MARK: Methods
    func resetValues() {
        self.email = ""
        self.password = ""
    }
    
    func changeState(_ newState: ProgressState) {
        withAnimation {
            state = newState
        }
    }
}
