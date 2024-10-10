//
//  LoginButton.swift
//  Task-App
//
//  Created by Simone Samardzhiev on 9.10.24.
//

import SwiftUI


/// Button used to login
struct LoginButton: View {
    /// Login view model.
    @Environment(LoginViewModel.self) var loginViewModel
    
    var body: some View {
        if loginViewModel.state.isIdle() {
            Button {
                
            } label: {
                Text("Login")
                    .foregroundStyle(Color.primary)
                    .font(.largeTitle)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                    }
            }
            .padding(.horizontal, CGFloat.paddingValue)
        }
    }
}
