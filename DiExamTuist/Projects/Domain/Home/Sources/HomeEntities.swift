//
//  HomeEntities.swift
//  HomeDomain
//
//  Created by 이지훈 on 7/1/25.
//

import Foundation

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

public protocol HomeRepository {
    func getCurrentUser() -> User?
    func updateUser(_ user: User)
}

public protocol GetCurrentUserUseCaseProtocol {
    func execute() -> User?
}
