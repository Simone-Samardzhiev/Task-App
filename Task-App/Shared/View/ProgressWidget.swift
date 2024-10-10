//
//  RegisterProgressView.swift
//  Task-App
//
//  Created by Simone Samardzhiev on 10.10.24.
//

import SwiftUI


/// View that will show the registration progress.
struct ProgressWidget: View {
    /// The state that will be shown.
    @Binding private var state: ProgressState
    
    /// Default initializer.
    /// - Parameter state: The state that will be shown.
    init(_ state: Binding<ProgressState>) {
        self._state = state
    }
    
    var body: some View {
        switch state {
        case .idle:
            EmptyView()
        case .processing(let message), .success(let message), .failure(let message):
            RoundedRectangle(cornerRadius: 10)
        }
    }
}
