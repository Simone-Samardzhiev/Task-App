//
//  TaskPriority.swift
//  Task-App
//
//  Created by Simone Samardzhiev on 11.10.24.
//

import Foundation


/// Enumeration that defines for types of priority for the task.
/// - low
/// - medium
/// - high
/// - vital
enum Priority: String, Codable, CaseIterable {
    case low = "Low"
    case medium = "Medium"
    case high = "High"
    case vital = "Vital"
}
