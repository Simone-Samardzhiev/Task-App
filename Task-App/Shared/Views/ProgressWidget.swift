//
//  ProgressWidget.swift
//  Task-App
//
//  Created by Simone Samardzhiev on 10.10.24.
//

import SwiftUI


/// View that will show the registration progress.
struct ProgressWidget: View {
    /// The state that will be shown.
    @Binding private var state: ProgressState
    /// Variable used to show and hide the indicator.
    @State private var showLineIndicator: Bool
    
    /// Default initializer.
    /// - Parameter state: The state that will be shown.
    init(_ state: Binding<ProgressState>) {
        self._state = state
        self.showLineIndicator = true
    }
    
    var body: some View {
        switch state {
        case .idle:
            EmptyView()
        case .processing(let message), .success(let message), .failure(let message):
            HStack {
                Text(message)
                
                if state.isProcessing() {
                    ProgressView()
                }
            }
            .padding(CGFloat.paddingValue)
            .background {
                backgroundView()
            }
            .padding(.bottom, CGFloat.paddingValue)
            .transition(
                .asymmetric(
                    insertion: .move(edge: .bottom),
                    removal: .move(edge: .bottom)
                )
            )
        }
    }
    
    /// Method that will return the view for the background.
    /// - Returns: The created view.
    private func backgroundView() -> some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(Color.accentColor)
            .overlay(alignment: .bottom) {
                if state.isSuccess() || state.isFailure() {
                    indicatorView()
                }
            }
            .overlay(alignment: .topTrailing) {
                if state.isSuccess() || state.isFailure() {
                    closeButtonView()
                }
            }
    }
    
    /// Method that will create the view for the indicator.
    /// - Returns: The created view.
    private func indicatorView() -> some View {
        Rectangle()
            .frame(maxWidth: showLineIndicator ? .infinity : .zero)
            .frame(height: 2)
            .onAppear {
                showLineIndicator = true
                withAnimation(.linear(duration: 5)) {
                    showLineIndicator = false
                }
            }
            .task {
                try? await Task.sleep(for: .seconds(5))
                
                await MainActor.run {
                    withAnimation {
                        state = .idle
                    }
                }
            }
    }
    
    /// Method that will create the view for the close button.
    /// - Returns: The created view.
    private func closeButtonView() -> some View {
        Button {
            withAnimation {
                state = .idle
            }
        } label: {
            Image(systemName: "xmark")
                .foregroundStyle(Color.primary)
        }
        .padding()
    }
}
