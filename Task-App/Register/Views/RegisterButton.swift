//
//  RegisterButton.swift
//  Task-App
//
//  Created by Simone Samardzhiev on 10.10.24.
//

import SwiftUI


/// Button used to register
struct RegisterButton: View {
    /// Register view model.
    @Environment(RegisterViewModel.self) var registerViewModel

    var body: some View {
        if registerViewModel.state.isIdle() {
            Button {
                Task {
                    await registerViewModel.register()
                }
            } label: {
                Text("Register")
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
