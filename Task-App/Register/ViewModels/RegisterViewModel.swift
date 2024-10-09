//
//  RegisterViewModel.swift
//  Task-App
//
//  Created by Simone Samardzhiev on 9.10.24.
//

import Foundation


/// View model used by register view.
class RegisterViewModel: RegisterViewModelProtocol {
    // MARK: Properties
    
    var email: String
    var password: String
    var confirmPassword: String
    var service: RegisterServiceProtocol
    
    // MARK: Initializer
    
    init(service: RegisterServiceProtocol) {
        self.email = ""
        self.password = ""
        self.confirmPassword = ""
        self.service = service
    }
    
    // MARK: Methods
    
    func checkEmail() -> Bool {
        let regex = try! Regex(#"[\w._%+0-]+@[\w._-]+\.[a-zA-Z]{2,}$"#)
        return email.contains(regex)
    }
    
    func checkPassword() -> Bool {
        let regex = try! Regex(#"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[_@$!%*?&#])[A-Za-z\d_@$!%*?&#]{8,}$"#)
        return password.contains(regex)
    }
    
    func resetValues() {
        self.email = ""
        self.password = ""
        self.confirmPassword = ""
    }
}
