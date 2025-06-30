//
//  UserRepository.swift
//  Domain
//
//  Created by 이지훈 on 6/30/25.
//

import Foundation

// MARK: - User Repository Protocol
public protocol UserRepository {
    func getCurrentUser() -> User?
    func updateUser(_ user: User)
}
