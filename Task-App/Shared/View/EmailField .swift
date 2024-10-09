//
//  EmailField .swift
//  Task-App
//
//  Created by Simone Samardzhiev on 9.10.24.
//

import SwiftUI


/// View used to enter an email.
struct EmailField: View {
    /// The email that will be entered.
    @Binding private var email: String
    
    
    /// Default initializer.
    /// - Parameter email: The email that will be entered.
    init(_ email: Binding<String>) {
        self._email = email
    }
    
    var body: some View {
        VStack {
            TextField("Email", text: $email)
            Rectangle()
                .frame(height: 1)
        }
        .padding(.horizontal, CGFloat.paddingValue)
        .padding(.bottom, CGFloat.paddingValue)
    }
}
