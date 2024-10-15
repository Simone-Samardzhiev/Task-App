//
//  TaskService.swift
//  Task-App
//
//  Created by Simone Samardzhiev on 11.10.24.
//

import Foundation


actor TaskService: TaskServiceProtocol {
    // MARK: Properties
    let decoder: JSONDecoder
    let encoder: JSONEncoder
    var token: String
    
    // MARK: Initializer
    
    init(_ token: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        self.decoder = JSONDecoder()
        self.decoder.dateDecodingStrategy = .formatted(dateFormatter)
        self.encoder = JSONEncoder()
        self.encoder.dateEncodingStrategy = .formatted(dateFormatter)
        self.token = token
    }
    
    // MARK: Methods
    
    func getTasks() async throws -> [TaskItem] {
        let dataResponse: Data // Variable storing the response data
        let urlResponse: URLResponse // Variable storing the url response.
        
        // Create the URL
        guard let url = URL(string: "http://localhost:8080/tasks") else {
            throw TaskError.invalidURL // Error if the URL is invalid
        }
        
        // Create request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        do {
            (dataResponse, urlResponse) = try await URLSession.shared.data(for: request) // Get data and response
        } catch URLError.notConnectedToInternet {
            throw TaskError.notConnected // Error if the use is not connected
        } catch {
            throw TaskError.unknownError // Error if there was an unknown error
        }
        
        // Check url response
        guard let httpResponse = urlResponse as? HTTPURLResponse else {
            throw TaskError.invalidURLResponse
        }
        
        // Check status code.
        switch httpResponse.statusCode {
        case 200:
            do {
                let tasks = try decoder.decode([TaskItem].self, from: dataResponse)
                return tasks
            } catch {
                throw TaskError.errorDecodingData // Error if the tasks failed to encode
            }
        case 401:
            throw TaskError.tokenExpired
        default:
            throw TaskError.invalidHTTPStatusCode // Error if the code was not expected
        }
    }
    
    func addTask(_ task: NewTaskItem) async throws {
        let urlResponse: URLResponse // Variable storing the url response.
        let taskData: Data // Variable storing the task data.
        
        do {
            taskData = try encoder.encode(task) // Encode task data
        } catch {
            throw TaskError.errorEncodingData // Error if the task data couldn't be encoded
        }
        
        // Create URL
        guard let url = URL(string: "http://localhost:8080/tasks") else {
            throw TaskError.invalidURL // Error if the URL is invalid
        }
        
        // Create request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = taskData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        do {
            (_, urlResponse) =   try await URLSession.shared.data(for: request) // Get URL response
        } catch URLError.notConnectedToInternet {
            throw TaskError.notConnected // Error if the user is not connected
        } catch {
            throw TaskError.unknownError // Error if there was an unknown error
        }
        
        // Check URL response
        guard let httpResponse = urlResponse as? HTTPURLResponse else {
            throw TaskError.invalidURLResponse // Error if the URL response is invalid
        }
        
        // Check status code
        switch httpResponse.statusCode {
        case 200:
            return
        case 401:
            throw TaskError.tokenExpired
        default:
            throw TaskError.invalidHTTPStatusCode // Error if the status code is not expected
        }
    }
    
    func deleteTask(_ task: TaskItem) async throws {
        let urlResponse: URLResponse // Variable storing URL response
        let taskData: Data // Variable storing task data
        
        do {
            taskData = try encoder.encode(task) // Encode task data
        } catch {
            throw TaskError.errorDecodingData // Error if the task data couldn't be encoded
        }
        
        // Create URL
        guard let url = URL(string: "http://localhost:8080/tasks") else {
            throw TaskError.invalidURL // Error if the URL is invalid
        }
        
        // Create request
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.httpBody = taskData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        do {
            (_, urlResponse) = try await URLSession.shared.data(for: request) // Get URL response
        } catch URLError.notConnectedToInternet {
            throw TaskError.notConnected // Error if the user is not connected
        } catch {
            throw TaskError.unknownError // Error if there was an unknown error
        }
        
        // Check URL response
        guard let httpResponse = urlResponse as? HTTPURLResponse else {
            throw TaskError.invalidURLResponse // Error if the response is invalid
        }
        
        // Check status code
        switch httpResponse.statusCode {
        case 200:
            return
        case 401:
            throw TaskError.tokenExpired
        default:
            throw TaskError.invalidHTTPStatusCode // Error if the status code in not expected.
        }
    }
    
    func updateTask(_ task: TaskItem) async throws {
        let urlResponse: URLResponse // Variable storing URL response
        let taskData: Data // Variable storing task data
        
        do {
            taskData = try encoder.encode(task) // Encode task data
        } catch {
            throw TaskError.errorDecodingData // Error if the task data couldn't be encoded
        }
        
        // Create URL
        guard let url = URL(string: "http://localhost:8080/tasks") else {
            throw TaskError.invalidURL // Error if the URL is invalid
        }
        
        // Create request
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.httpBody = taskData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        do {
            (_, urlResponse) = try await URLSession.shared.data(for: request) // Get URL response
        } catch URLError.notConnectedToInternet {
            throw TaskError.notConnected // Error if the user is not connected
        } catch {
            throw TaskError.unknownError // Error if there was an unknown error
        }
        
        // Check URL response
        guard let httpResponse = urlResponse as? HTTPURLResponse else {
            throw TaskError.invalidURLResponse // Error if the response is invalid
        }
        
        // Check status code
        switch httpResponse.statusCode {
        case 200:
            return
        case 410:
            throw TaskError.tokenExpired
        default:
            throw TaskError.invalidHTTPStatusCode // Error if the status code in not expected.
        }
    }
    
    func refreshToken() async throws {
        let dataResponse: Data // Variable string the data response
        let urlResponse: URLResponse // Variable storing the URL response
        
        // Create URL
        guard let url = URL(string: "http://localhost:8080/users/refreshToken") else {
            throw TaskError.invalidURL // Error if the URL is invalid
        }
        
        // Create request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        do {
            (dataResponse, urlResponse) = try await URLSession.shared.data(for: request) // Get response data and URL response
        } catch URLError.notConnectedToInternet {
            throw TaskError.notConnected // Error if the user is not connected
        } catch {
            throw TaskError.unknownError // Error if there was an unknown error
        }
        
        // Check URL
        guard let httpResponse = urlResponse as? HTTPURLResponse else {
            throw TaskError.invalidURLResponse // Error if the URL is invalid
        }
        
        // Check status code
        switch httpResponse.statusCode {
        case 200:
            guard let newToken = String(data: dataResponse, encoding: .utf8) else {
                throw TaskError.invalidToken // Error if the token data couldn't be transformed to string
            }
            token = newToken
        case 401:
            throw TaskError.tokenExpired
        default:
            throw TaskError.invalidHTTPStatusCode // Error if the status code is not expected
        }
    }
}
