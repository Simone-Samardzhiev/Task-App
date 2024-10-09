//
//  LoginView.swift
//  Task-App
//
//  Created by Simone Samardzhiev on 8.10.24.
//

import SwiftUI

/// View used to login.
struct LoginView: View {
    /// Login view model.
    @State private var loginViewModel: LoginViewModel
    
    /// Default initializer.
    init () {
        let service = LoginService()
        self.loginViewModel = LoginViewModel(service: service)
    }
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                VStack {
                    EmailField($loginViewModel.email)
                    PasswordField($loginViewModel.password)
                }
                .padding(.top, geometry.size.height / 3)
                .environment(loginViewModel)
                .navigationTitle("Login")
            }
        }
    }
}

#Preview {
    LoginView()
}
