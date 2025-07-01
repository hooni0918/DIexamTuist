//
//  UserRepository.swift
//  Data
//
//  Created by 이지훈 on 7/1/25.
//

import Foundation
import Domain

public final class UserRepository: UserRepositoryProtocol {
    private var currentUser: User?
    
    public init() {
        print("👤 UserRepository 생성")
    }
    
    public func getCurrentUser() -> User? {
        print("📖 사용자 정보 조회")
        return currentUser ?? User(
            id: "1",
            name: "이지훈",
            email: "test@example.com"
        )
    }
    
    public func updateUser(_ user: User) {
        print("💾 사용자 정보 업데이트: \(user.name)")
        currentUser = user
    }
}
