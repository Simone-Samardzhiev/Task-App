//
//  LoginViewModel.swift
//  Task-App
//
//  Created by Simone Samardzhiev on 8.10.24.
//

import Foundation


/// View model that will manage the log in.
@Observable
class LoginViewModel: LoginViewModelProtocol {
    // MARK: Properties
    
    var email: String
    var password: String
    let service: LoginServiceProtocol
    
    // MARK: Initializer.
    
    init(service: LoginServiceProtocol) {
        self.email = ""
        self.password = ""
        self.service = service
    }
}
