//
//  RegisterError.swift
//  Task-App
//
//  Created by Simone Samardzhiev on 9.10.24.
//

import Foundation


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
