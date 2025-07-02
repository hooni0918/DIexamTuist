//
//  ProfileEntities.swift
//  ProfileDomain
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

public protocol UserRepository {
    func getCurrentUser() -> User?
    func updateUser(_ user: User)
}

public protocol GetUserUseCaseProtocol {
    func execute() -> User?
}

public protocol UpdateUserUseCaseProtocol {
    func execute(_ user: User)
}
