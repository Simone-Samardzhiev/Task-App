//
//  RegisterView.swift
//  Task-App
//
//  Created by Simone Samardzhiev on 9.10.24.
//

import SwiftUI


/// View used to register 
struct RegisterView: View {
    /// Register view model.
    @State private var registerViewModel: RegisterViewModel
    
    /// Default initializer.
    init() {
        let service = RegisterService()
        self.registerViewModel = RegisterViewModel(service: service)
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                EmailField($registerViewModel.email)
                PasswordField($registerViewModel.password)
                PasswordField($registerViewModel.confirmPassword, withPadding: false)
                BackButton()
                RegisterButton()
                Spacer()
                ProgressWidget($registerViewModel.state)
            }
            .ignoresSafeArea()
            .padding(.top, geometry.size.height / 3)
            .navigationBarBackButtonHidden()
            .navigationTitle("Register")
            .environment(registerViewModel)
        }
        .onDisappear {
            registerViewModel.resetValues()
        }
    }
}
