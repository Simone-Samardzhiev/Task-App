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
    var token: String?
    @ObservationIgnored let service: LoginServiceProtocol
    
    // MARK: Initializer.
    
    init(service: LoginServiceProtocol) {
        self.email = ""
        self.password = ""
        self.state = .idle
        self.token = nil
        self.service = service
    }
    
    // MARK: Methods
    func resetValues() {
        self.email = ""
        self.password = ""
        self.state = .idle
    }
    
    func login() async {
        await MainActor.run {
            changeState(.processing("Logging"))
        }
        
        do {
            let token = try await service.login(email: email, password: password)
            await MainActor.run {
                self.token = token
            }
        } catch let error as LoginError {
            await MainActor.run {
                handleLoginError(error)
            }
        } catch {
            await MainActor.run {
                handleUnknownError(error)
            }
        }
    }
    
    func handleLoginError(_ error: LoginError) {
        switch error {
        case .wrongCredentials:
            changeState(.failure("The email or the password is wrong!"))
        case .notConnected:
            changeState(.failure("Please check you connection!"))
        default:
            changeState(.failure("There was an unknown error!"))
#if DEBUG
            print("Unknown error: \(error)")
#endif
        }
    }
    
    func handleUnknownError(_ error: any Error) {
        changeState(.failure("There was an unknown error!"))
#if DEBUG
        print("Unknown error: \(error)")
#endif
    }
    
    func changeState(_ newState: ProgressState) {
        withAnimation {
            state = newState
        }
    }
}
