//
//  Constants.swift
//  Shared
//
//  Created by 이지훈 on 6/30/25.
//

import Foundation

// MARK: - App Constants
public struct Constants {
    public struct API {
        public static let baseURL = "https://api.example.com"
        public static let timeout: TimeInterval = 30
    }
    
    public struct UI {
        public static let cornerRadius: CGFloat = 10
        public static let padding: CGFloat = 16
    }
}
