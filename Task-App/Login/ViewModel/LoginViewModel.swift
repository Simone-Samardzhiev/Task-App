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
    var email = ""
    var password = ""
}
