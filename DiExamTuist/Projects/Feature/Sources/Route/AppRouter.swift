//
//  AppRouter.swift
//  Feature
//
//  Created by 이지훈 on 7/1/25.
//


import Foundation

// MARK: - App Router Definitions
public enum AppRouter {
    public enum Screen: Hashable {
        case home
        case profile
        case login
        case calendar
        case onboarding
    }
    
    public enum Sheet: String, Identifiable {
        case settings
        case help
        
        public var id: String { self.rawValue }
    }
    
    public enum FullScreen: String, Identifiable {
        case onboarding
        case tutorial
        
        public var id: String { self.rawValue }
    }
}
