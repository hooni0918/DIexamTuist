//
//  LoginUseCases.swift
//  App
//
//  Created by 이지훈 on 7/2/25.
//

import Foundation
import LoginDomain

public final class LoginUseCase: LoginUseCaseProtocol {
    private let authRepository: AuthRepository
    
    public init(authRepository: AuthRepository) {
        self.authRepository = authRepository
        print("🔑 LoginUseCase 생성 (App에서)")
    }
    
    public func execute(email: String, password: String) async -> Result<Bool, Error> {
        print("🔐 로그인 시도: \(email)")
        return await authRepository.login(email: email, password: password)
    }
}

public final class LogoutUseCase: LogoutUseCaseProtocol {
    private let authRepository: AuthRepository
    
    public init(authRepository: AuthRepository) {
        self.authRepository = authRepository
        print("🚪 LogoutUseCase 생성 (App에서)")
    }
    
    public func execute() {
        print("👋 로그아웃 실행")
        authRepository.logout()
    }
}
