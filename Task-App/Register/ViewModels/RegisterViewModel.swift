//
//  RegisterViewModel.swift
//  Task-App
//
//  Created by Simone Samardzhiev on 9.10.24.
//

import Foundation


/// View model used by register view.
@Observable
class RegisterViewModel: RegisterViewModelProtocol {
    // MARK: Properties
    
    var email: String
    var password: String
    var confirmPassword: String
    var state: ProgressState
    @ObservationIgnored let service: RegisterServiceProtocol
    
    // MARK: Initializer
    
    init(service: RegisterServiceProtocol) {
        self.email = ""
        self.password = ""
        self.confirmPassword = ""
        self.state = .idle
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
        self.state = .idle
    }
    
    func register() async {
        if !checkEmail() {
            await MainActor.run {
                state = .failure("The email is invalid!")
            }
            return
        }
        
        if password != confirmPassword {
            await MainActor.run {
                state = .failure("The passwords do not match!")
            }
            return
        }
        
        if !checkPassword() {
            await MainActor.run {
                state = .failure("The password is not strong enough!")
            }
            return
        }
        
        do {
            try await service.register(email: email, password: password)
        } catch let error as RegisterError {
            await MainActor.run {
                handleRegisterError(error: error)
            }
        } catch {
            await MainActor.run {
                handleUnknownError(error: error)
            }
        }
    }
    
    func handleRegisterError(error: RegisterError)  {
        switch error {
        case .emailInUse:
            state = .failure("The email is already in use!")
        case .notConnected:
            state = .failure("Please check you connection!")
        default:
            state = .failure("There was an unknown error!")
            #if DEBUG
            print("Unknown error: \(error)")
            #endif
        }
    }
    
    func handleUnknownError(error: Error) {
        state = .failure("There was an unknown error!")
        #if DEBUG
        print("Unknown error: \(error)")
        #endif
    }
}
