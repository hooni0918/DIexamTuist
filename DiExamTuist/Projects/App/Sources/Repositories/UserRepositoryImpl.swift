//
//  UserRepositoryImpl.swift
//  App
//
//  Created by 이지훈 on 7/2/25.
//

import Foundation
import Core
import ProfileDomain

public final class UserRepositoryImpl: UserRepository {
    private var currentUser: User?
    
    public init() {
        print("👤 UserRepositoryImpl 생성 (App에서)")
    }
    
    public func getCurrentUser() -> User? {
        return currentUser ?? User(
            id: "1",
            name: "이지훈",
            email: "profile@example.com"
        )
    }
    
    public func updateUser(_ user: User) {
        print("💾 프로필 사용자 업데이트: \(user.name)")
        currentUser = user
    }
}
