//
//  TaskError.swift
//  Task-App
//
//  Created by Simone Samardzhiev on 11.10.24.
//

import Foundation


/// Enumeration representing the errors that may be thrown during user log in process.
///
/// - invalidToken: Error thrown when the task data couldn't be transformed to string.
/// - tokenExpired: Error thrown when the task has been expired before refreshing.
/// - unknownError: An unspecified error occurred, typically used as a fallback.
/// - errorEncodingData: Failed to encode task data for the request.
/// - errorDecodingData: Failed to decode task data from the response.
/// - invalidURL: The URL for the tasks endpoint is invalid.
/// - notConnected: The device is not connected to the internet.
/// - invalidURLResponse: The response received is not a valid URL response.
/// - invalidHTTPStatusCode: The HTTP status code in not recognized or expected.
enum TaskError: Error {
    case invalidToken
    case tokenExpired
    case unknownError
    case errorEncodingData
    case errorDecodingData
    case invalidURL
    case notConnected
    case invalidURLResponse
    case invalidHTTPStatusCode
}

