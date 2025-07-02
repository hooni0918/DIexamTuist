//
//  AuthRepositoryImpl.swift
//  LoginData
//
//  Created by 이지훈 on 7/1/25.
//

import Foundation
import Core
import LoginDomain

public final class AuthRepositoryImpl: AuthRepository {
    private var loggedIn = false
    
    public init() {
        print("🔐 AuthRepositoryImpl 생성")
    }
    
    public func login(email: String, password: String) async -> Result<Bool, Error> {
        print("🔑 로그인 처리: \(email)")
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        
        if !email.isEmpty && !password.isEmpty {
            loggedIn = true
            return .success(true)
        } else {
            return .failure(AuthError.invalidCredentials)
        }
    }
    
    public func logout() {
        print("👋 로그아웃")
        loggedIn = false
    }
    
    public func isLoggedIn() -> Bool {
        return loggedIn
    }
}

public final class LoginUseCase: LoginUseCaseProtocol {
    private let authRepository: AuthRepository
    
    public init(authRepository: AuthRepository) {
        self.authRepository = authRepository
        print("🔑 LoginUseCase 생성")
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
        print("🚪 LogoutUseCase 생성")
    }
    
    public func execute() {
        print("👋 로그아웃 실행")
        authRepository.logout()
    }
}
