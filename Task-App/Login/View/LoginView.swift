//
//  LoginView.swift
//  Task-App
//
//  Created by Simone Samardzhiev on 8.10.24.
//

import SwiftUI

/// View used to log in.
struct LoginView: View {
    @State var loginViewModel = LoginViewModel()
    
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
