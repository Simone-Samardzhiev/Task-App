//
//  PasswordField.swift
//  Task-App
//
//  Created by Simone Samardzhiev on 9.10.24.
//

import SwiftUI


/// Field used to enter the password.
struct PasswordField: View {
    /// The password that will be entered.
    @Binding private var password: String
    /// Variable used to show the password.
    @State private var showPassword: Bool
    
    /// Default initializer.
    /// - Parameter password: The password that will entered
    init(_ password: Binding<String>) {
        self._password = password
        self.showPassword = false
    }
    
    var body: some View {
        VStack {
            HStack {
                if showPassword {
                    TextField("Password", text: $password)
                } else {
                    SecureField("Password", text: $password)
                }
                
                Button {
                    withAnimation {
                        showPassword.toggle()
                    }
                } label: {
                    if showPassword {
                        Image(systemName: "eye")
                    } else {
                        Image(systemName: "eye.slash")
                    }
                }
            }
            Rectangle()
                .frame(height: 1)
        }
        .padding(.horizontal, CGFloat.paddingValue)
        .padding(.bottom, CGFloat.paddingValue)
    }
}
