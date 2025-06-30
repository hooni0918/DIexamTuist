//
//  Logger.swift
//  Core
//
//  Created by 이지훈 on 6/30/25.
//

import Foundation

// MARK: - Logger
public class Logger {
    public static let shared = Logger()
    
    private init() {}
    
    public func log(_ message: String, level: LogLevel = .info) {
        print("[\(level.rawValue)] \(Date()): \(message)")
    }
}

public enum LogLevel: String {
    case debug = "DEBUG"
    case info = "INFO"
    case warning = "WARNING"
    case error = "ERROR"
}
