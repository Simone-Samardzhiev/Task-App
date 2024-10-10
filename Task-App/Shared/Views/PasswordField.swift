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
    /// Variable used to apply or remove padding.
    let withPadding: Bool
    
    /// Default initializer.
    /// - Parameter password: The password that will entered
    init(_ password: Binding<String>, withPadding: Bool = true) {
        self._password = password
        self.showPassword = false
        self.withPadding = withPadding
    }
    
    var body: some View {
        VStack {
            HStack {
                Group {
                    if showPassword {
                        TextField("Password", text: $password)
                    } else {
                        SecureField("Password", text: $password)
                    }
                }
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                
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
        .padding(.bottom, withPadding ? CGFloat.paddingValue : 0)
    }
}
