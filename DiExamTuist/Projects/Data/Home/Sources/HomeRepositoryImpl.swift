//
//  HomeRepositoryImpl.swift
//  HomeData
//
//  Created by 이지훈 on 7/1/25.
//

import Foundation
import Core
import HomeDomain

public final class HomeRepositoryImpl: HomeRepository {
    public init() {
        print("🏠 HomeRepositoryImpl 생성")
    }
    
    public func getCurrentUser() -> User? {
        return User(id: "1", name: "이지훈", email: "home@example.com")
    }
    
    public func updateUser(_ user: User) {
        print("💾 홈 사용자 업데이트: \(user.name)")
    }
}

public final class GetCurrentUserUseCase: GetCurrentUserUseCaseProtocol {
    private let homeRepository: HomeRepository
    
    public init(homeRepository: HomeRepository) {
        self.homeRepository = homeRepository
        print("📋 GetCurrentUserUseCase 생성")
    }
    
    public func execute() -> User? {
        print("👤 현재 사용자 정보 조회")
        return homeRepository.getCurrentUser()
    }
}
