//
//  RegisterLink .swift
//  Task-App
//
//  Created by Simone Samardzhiev on 9.10.24.
//

import SwiftUI


/// Link used to go to registration view.
struct RegisterLink: View {
    /// Login view model.
    @Environment(LoginViewModel.self) var loginViewModel
    
    var body: some View {
        if loginViewModel.state.isFailure() {
            HStack {
                NavigationLink("Don't have an account?") {
                    RegisterView()
                }
                Spacer()
            }
            .padding(.horizontal, CGFloat.paddingValue)
            .padding(.bottom, CGFloat.paddingValue)
        }
    }
}
