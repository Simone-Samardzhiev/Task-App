//
//  RegisterService.swift
//  Task-App
//
//  Created by Simone Samardzhiev on 9.10.24.
//

import Foundation


/// Actor responsible for register-related operations
actor RegisterService: RegisterServiceProtocol {
    let encoder: JSONEncoder
    
    init() {
        self.encoder = JSONEncoder()
    }
    
    func register(email: String, password: String) async throws {
        let user = User(email: email, password: password) // Create user model
        let userData: Data // Variable storing the user data
        let urlResponse: URLResponse // Variable storing the user
        
        do {
            userData = try encoder.encode(user) // Encode the user 
        } catch {
            throw RegisterError.errorEncodingData // Error if the user model fails to encode
        }
        
        // Create URL
        guard let url = URL(string: "http://localhost:8080/users/register") else {
            throw RegisterError.invalidURL // Error if the URL is invalid 
        }
        
        // Create the request 
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = userData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            (_, urlResponse) = try await URLSession.shared.data(for: request) // Get response 
        } catch URLError.notConnectedToInternet {
            throw RegisterError.notConnected // Error if the user is not connected to wifi
        } catch {
            throw RegisterError.unknownError // Error if there was an unknown error
        }
        
        // Check response 
        guard let httpResponse = urlResponse as? HTTPURLResponse else {
            throw RegisterError.invalidURLResponse // Error if the response in invalid 
        }
        
        switch httpResponse.statusCode {
        case 200:
            return // The user is registered so we return
        case 409:
            throw RegisterError.emailInUse // Error if the email is already in use
        default:
            throw RegisterError.invalidHTTPStatusCode // Error if the response code is not expected 
        }
    }
}
