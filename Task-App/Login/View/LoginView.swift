//
//  LoginView.swift
//  Task-App
//
//  Created by Simone Samardzhiev on 8.10.24.
//

import SwiftUI

/// View used to log in.
struct LoginView: View {
    @State var loginViewModel: LoginViewModelProtocol = LoginViewModel()
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                VStack {
                }
                .navigationTitle("Login")
            }
        }
    }
}

#Preview {
    LoginView()
}
