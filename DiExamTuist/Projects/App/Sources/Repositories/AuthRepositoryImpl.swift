//
//  AuthRepositoryImpl.swift
//  App
//
//  Created by 이지훈 on 7/2/25.
//

import Foundation
import Core
import LoginDomain

public final class AuthRepositoryImpl: AuthRepository {
    private var loggedIn = false
    
    public init() {
        print("🔐 AuthRepositoryImpl 생성 (App에서)")
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
