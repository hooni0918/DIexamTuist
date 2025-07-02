//
//  HomeRepositoryImpl.swift
//  App
//
//  Created by 이지훈 on 7/2/25.
//

import Foundation
import Core
import HomeDomain

// ✅ public으로 변경
public final class HomeRepositoryImpl: HomeRepository {
    public init() {
        print("🏠 HomeRepositoryImpl 생성 (App에서)")
    }
    
    public func getCurrentUser() -> User? {
        return User(id: "1", name: "이지훈", email: "home@example.com")
    }
    
    public func updateUser(_ user: User) {
        print("💾 홈 사용자 업데이트: \(user.name)")
    }
}
