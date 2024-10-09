//
//  LoginService.swift
//  Task-App
//
//  Created by Simone Samardzhiev on 9.10.24.
//

import Foundation


/// An actor responsible for login-related operation.
actor LoginService: LoginServiceProtocol {
    // MARK: Properties
    
    let encoder: JSONEncoder
    
    // MARK: Initializer
    
    /// Default initializer.
    init() {
        self.encoder = JSONEncoder()
    }
    
    // MARK: Method
    
    func login(email: String, password: String) async throws -> String {
        let user = User(email: email, password: password) // Create user model
        let userData: Data // Variable storing the user data
        let responseData: Data // Variable storing the response data
        let urlResponse: URLResponse // Variable storing the url response
        
        do {
            userData = try encoder.encode(user) // Encode the user
        } catch {
            throw LoginError.errorEncodingData // Error if the user model fails to encode
        }
        
        // Create URL
        guard let url = URL(string: "http://localhost:8080/users/login") else {
            throw LoginError.invalidURL // Error if the URL is invalid
        }
        
        // Create request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = userData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            (responseData, urlResponse) = try await URLSession.shared.data(for: request) // Get data and response
        } catch URLError.notConnectedToInternet {
            throw LoginError.notConnected // Error if the user is not connected to wifi
        } catch {
            throw LoginError.unknownError // Error if there was an unknown error
        }
        
        // Check response
        guard let httpResponse = urlResponse as? HTTPURLResponse else {
            throw LoginError.invalidURLResponse // Error if the response is invalid
        }
        
        // Check the status code
        switch httpResponse.statusCode {
        case 200:
            // Transform token to string
            guard let token = String(data: responseData, encoding: .utf8) else {
                throw LoginError.invalidDataResponse // Error if the token failed to transform to string
            }
            return token
        case 401:
            throw LoginError.wrongCredentials // Error if the user credentials were wrong
        default:
            throw LoginError.invalidHTTPStatusCode // Error thrown if the status code is not expected
        }
    }
}
