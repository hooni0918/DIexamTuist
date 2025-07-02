//
//  UserRepositoryImpl.swift
//  ProfileData
//
//  Created by 이지훈 on 7/1/25.
//

import Foundation
import Core
import ProfileDomain

public final class UserRepositoryImpl: UserRepository {
    private var currentUser: User?
    
    public init() {
        print("👤 UserRepositoryImpl 생성")
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

public final class GetUserUseCase: GetUserUseCaseProtocol {
    private let userRepository: UserRepository
    
    public init(userRepository: UserRepository) {
        self.userRepository = userRepository
        print("📋 GetUserUseCase 생성")
    }
    
    public func execute() -> User? {
        print("👤 프로필 사용자 정보 조회")
        return userRepository.getCurrentUser()
    }
}

public final class UpdateUserUseCase: UpdateUserUseCaseProtocol {
    private let userRepository: UserRepository
    
    public init(userRepository: UserRepository) {
        self.userRepository = userRepository
        print("✏️ UpdateUserUseCase 생성")
    }
    
    public func execute(_ user: User) {
        print("📝 사용자 정보 업데이트: \(user.name)")
        userRepository.updateUser(user)
    }
}
