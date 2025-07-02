//
//  ProfileUseCases.swift
//  App
//
//  Created by 이지훈 on 7/2/25.
//

import Foundation
import ProfileDomain

public final class GetUserUseCase: GetUserUseCaseProtocol {
    private let userRepository: UserRepository
    
    public init(userRepository: UserRepository) {
        self.userRepository = userRepository
        print("📋 GetUserUseCase 생성 (App에서)")
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
        print("✏️ UpdateUserUseCase 생성 (App에서)")
    }
    
    public func execute(_ user: User) {
        print("📝 사용자 정보 업데이트: \(user.name)")
        userRepository.updateUser(user)
    }
}
