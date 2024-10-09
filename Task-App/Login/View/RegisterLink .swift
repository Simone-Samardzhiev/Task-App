//
//  RegisterLink .swift
//  Task-App
//
//  Created by Simone Samardzhiev on 9.10.24.
//

import SwiftUI


/// Link used to go to registration view.
struct RegisterLink: View {
    
    var body: some View {
        HStack {
            NavigationLink("Don't have an account?") {
                RegisterView()
            }
            Spacer()
        }
        .padding(.horizontal, CGFloat.paddingValue)
    }
}
