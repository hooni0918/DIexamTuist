//
//  UserRepositoryImpl.swift
//  Data
//
//  Created by 이지훈 on 6/30/25.
//

import Foundation
import Domain

// MARK: - User Repository Implementation
public class UserRepositoryImpl: UserRepository {
    private var currentUser: User?
    
    public init() {}
    
    public func getCurrentUser() -> User? {
        return currentUser ?? User(
            id: "1",
            name: "이지훈",
            email: "test@example.com"
        )
    }
    
    public func updateUser(_ user: User) {
        currentUser = user
    }
}
