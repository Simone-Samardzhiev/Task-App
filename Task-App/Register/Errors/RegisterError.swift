//
//  RegisterError.swift
//  Task-App
//
//  Created by Simone Samardzhiev on 9.10.24.
//

import Foundation


/// Enumeration representing the errors that may be thrown during user registering process.
///
/// - emailInUse: The provided email is already used by another user.
/// - unknownError: An unspecified error occurred, typically used as a fallback.
/// - errorEncodingData: Failed to encode user data for the request.
/// - invalidURL: The URL for the login endpoint is invalid.
/// - notConnected: The device is not connected to the internet.
/// - invalidURLResponse: The response received is not a valid URL response.
/// - invalidHTTPStatusCode: The HTTP status code in not recognized or expected.
/// - invalidDataResponse: The data cannot be interpreted as expected

enum RegisterError : Error {
    case emailInUse
    case unknownError
    case errorEncodingData
    case invalidURL
    case notConnected
    case invalidURLResponse
    case invalidHTTPStatusCode
    case invalidDataResponse
}
