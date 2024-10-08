//
//  LoginViewModelProtocol.swift
//  Task-App
//
//  Created by Simone Samardzhiev on 8.10.24.
//

import Foundation

/// Protocol used to create login view model.
protocol LoginViewModelProtocol {
    /// The email of the user.
    var email: String {get set}
    /// The password of the user.
    var password: String {get set}
}
