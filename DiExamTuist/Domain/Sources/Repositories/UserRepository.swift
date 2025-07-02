//
//  UserRepository.swift
//  Domain
//
//  Created by 이지훈 on 6/30/25.
//

import Foundation

public protocol UserRepository {
    func getCurrentUser() -> User?
    func updateUser(_ user: User)
}
