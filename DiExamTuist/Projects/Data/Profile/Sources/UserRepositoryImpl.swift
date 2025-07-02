//
//  UserRepositoryImpl.swift
//  ProfileData
//
//  Created by 이지훈 on 7/2/25.
//

import Foundation
import Core
import ProfileDomain

// ✅ 미래를 위한 Skeleton 구현체
public final class UserRepositoryImpl: UserRepository {
    private var currentUser: User?
    private let logger: Logger
    private let networkManager: NetworkManager
    
    public init() {
        self.logger = Logger.shared
        self.networkManager = NetworkManager.shared
        print("👤 UserRepositoryImpl 생성 (Skeleton - 미래 사용 준비)")
    }
    
    public func getCurrentUser() -> User? {
        logger.log("🔍 현재 사용자 정보 조회 (실제 API 연동 예정)")
        
        // TODO: 실제 API 연동 시 구현
        // let response = try await networkManager.request("/api/profile")
        // return User.fromDTO(response)
        
        // 현재는 기본값 반환 (Mock 데이터를 Feature에서 직접 관리)
        return currentUser ?? User(
            id: "skeleton_user",
            name: "Skeleton User",
            email: "skeleton@example.com"
        )
    }
    
    public func updateUser(_ user: User) {
        logger.log("💾 사용자 정보 업데이트: \(user.name) (실제 API 연동 예정)")
        
        // TODO: 실제 API 연동 시 구현
        // let updateRequest = UpdateUserRequest.fromUser(user)
        // try await networkManager.request("/api/profile", method: .PUT, body: updateRequest)
        
        currentUser = user
        print("📝 사용자 정보 업데이트 Skeleton 완료")
    }
}

// ✅ 미래를 위한 UseCase Skeleton들
public final class GetUserUseCase: GetUserUseCaseProtocol {
    private let userRepository: UserRepository
    
    public init(userRepository: UserRepository) {
        self.userRepository = userRepository
        print("📋 GetUserUseCase 생성 (Skeleton - 미래 사용 준비)")
    }
    
    public func execute() -> User? {
        print("👤 사용자 정보 조회 실행 (Skeleton)")
        
        // TODO: 실제 비즈니스 로직 구현
        // - 캐싱 처리
        // - 권한 확인
        // - 데이터 변환
        
        return userRepository.getCurrentUser()
    }
}

public final class UpdateUserUseCase: UpdateUserUseCaseProtocol {
    private let userRepository: UserRepository
    
    public init(userRepository: UserRepository) {
        self.userRepository = userRepository
        print("✏️ UpdateUserUseCase 생성 (Skeleton - 미래 사용 준비)")
    }
    
    public func execute(_ user: User) {
        print("📝 사용자 정보 업데이트 실행 (Skeleton)")
        
        // TODO: 실제 비즈니스 로직 구현
        // - 입력 검증
        // - 권한 확인
        // - 변경사항 추적
        
        userRepository.updateUser(user)
    }
}
