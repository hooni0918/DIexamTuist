//
//  AuthRepositoryImpl.swift
//  LoginData
//
//  Created by 이지훈 on 7/2/25.
//

import Foundation
import Core
import LoginDomain

public final class AuthRepositoryImpl: AuthRepository {
    private var isLoggedIn = false
    private let logger: Logger
    private let networkManager: NetworkManager
    
    public init() {
        self.logger = Logger.shared
        self.networkManager = NetworkManager.shared
        print("🔐 AuthRepositoryImpl 생성 (Skeleton - 미래 사용 준비)")
    }
    
    public func login(email: String, password: String) async -> Result<Bool, Error> {
        logger.log("🔑 로그인 요청: \(email) (실제 API 연동 예정)")
        
        // let loginRequest = LoginRequest(email: email, password: password)
        // let response = try await networkManager.request("/api/auth/login", method: .POST, body: loginRequest)
        
        await Task.sleep(1_000_000_000) // 1초 대기 시뮬레이션
        return .failure(AuthError.unknown)
    }
    
    public func logout() {
        logger.log("👋 로그아웃 요청 (실제 API 연동 예정)")
        
        // - 토큰 삭제
        // - 캐시 클리어
        // - 서버 로그아웃 요청
        
        isLoggedIn = false
        print("🚪 로그아웃 Skeleton 완료")
    }
    
    public func isLoggedIn() -> Bool {
        // - 토큰 유효성 검증
        // - 서버 상태 확인
        
        return isLoggedIn
    }
}

public final class LoginUseCase: LoginUseCaseProtocol {
    private let authRepository: AuthRepository
    
    public init(authRepository: AuthRepository) {
        self.authRepository = authRepository
        print("🔑 LoginUseCase 생성 (Skeleton - 미래 사용 준비)")
    }
    
    public func execute(email: String, password: String) async -> Result<Bool, Error> {
        print("🔐 로그인 실행 (Skeleton)")
        
        // - 입력 검증
        // - 보안 처리
        // - 에러 핸들링
        
        return await authRepository.login(email: email, password: password)
    }
}

public final class LogoutUseCase: LogoutUseCaseProtocol {
    private let authRepository: AuthRepository
    
    public init(authRepository: AuthRepository) {
        self.authRepository = authRepository
        print("🚪 LogoutUseCase 생성 (Skeleton - 미래 사용 준비)")
    }
    
    public func execute() {
        print("👋 로그아웃 실행 (Skeleton)")
        
        // - 사용자 확인
        // - 데이터 정리
        // - 상태 초기화
        
        authRepository.logout()
    }
}
