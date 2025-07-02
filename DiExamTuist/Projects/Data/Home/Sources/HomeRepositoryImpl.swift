//
//  HomeRepositoryImpl.swift
//  HomeData
//
//  Created by 이지훈 on 7/2/25.
//

import Foundation
import Core
import HomeDomain

// ✅ 미래를 위한 Skeleton 구현체
// 현재는 사용되지 않지만, 마이그레이션 시 즉시 활성화 가능
public final class HomeRepositoryImpl: HomeRepository {
    private let logger: Logger
    private let networkManager: NetworkManager
    
    public init() {
        self.logger = Logger.shared
        self.networkManager = NetworkManager.shared
        print("🏠 HomeRepositoryImpl 생성 (Skeleton - 미래 사용 준비)")
    }
    
    public func getCurrentUser() -> User? {
        logger.log("🔍 현재 사용자 조회 요청 (실제 API 연동 예정)")
        
        // TODO: 실제 API 연동 시 구현
        // return try await networkManager.request("/api/user/current")
        
        // 현재는 nil 반환 (Mock 데이터를 Feature에서 직접 관리)
        return nil
    }
    
    public func updateUser(_ user: User) {
        logger.log("💾 사용자 정보 업데이트 요청: \(user.name) (실제 API 연동 예정)")
        
        // TODO: 실제 API 연동 시 구현
        // try await networkManager.request("/api/user/update", method: .POST, body: user)
        
        print("📝 사용자 업데이트 Skeleton 완료")
    }
}

// ✅ 미래를 위한 UseCase Skeleton
public final class GetCurrentUserUseCase: GetCurrentUserUseCaseProtocol {
    private let homeRepository: HomeRepository
    
    public init(homeRepository: HomeRepository) {
        self.homeRepository = homeRepository
        print("📋 GetCurrentUserUseCase 생성 (Skeleton - 미래 사용 준비)")
    }
    
    public func execute() -> User? {
        print("👤 현재 사용자 정보 조회 (Skeleton)")
        
        // TODO: 실제 비즈니스 로직 구현
        // - 캐싱 처리
        // - 에러 핸들링
        // - 데이터 변환
        
        return homeRepository.getCurrentUser()
    }
}
