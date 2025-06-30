//
//  User.swift
//  Domain
//
//  Created by 이지훈 on 6/30/25.
//

import Foundation

// MARK: - Domain Entity
public struct User {
    public let id: String
    public let name: String
    public let email: String
    
    public init(id: String, name: String, email: String) {
        self.id = id
        self.name = name
        self.email = email
    }
}
