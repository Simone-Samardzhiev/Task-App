//
//  BackButton.swift
//  Task-App
//
//  Created by Simone Samardzhiev on 9.10.24.
//

import SwiftUI


/// Button used to go back to login view.
struct BackButton: View {
    /// Register view model.
    @Environment(RegisterViewModel.self) var registerViewModel
    /// Variable used to close the register view.
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        if registerViewModel.state.isIdle() {
            HStack {
                Button("Have an account?") {
                    dismiss.callAsFunction()
                }
                Spacer()
            }
            .padding(.horizontal, CGFloat.paddingValue)
        }
    }
}
