//
//  AuthRepository.swift
//  Data
//
//  Created by 이지훈 on 6/30/25.
//

import Foundation
import Domain

public final class AuthRepository: AuthRepositoryProtocol {
    private var loggedIn = false
    
    public init() {
        print("🔐 AuthRepository 생성")
    }
    
    public func login(email: String, password: String) async -> Result<Bool, Error> {
        print("🔑 로그인 처리 시작: \(email)")
        
        // 네트워크 지연 시뮬레이션
        try? await Task.sleep(nanoseconds: 1_000_000_000) // 1초
        
        if !email.isEmpty && !password.isEmpty {
            loggedIn = true
            print("✅ 로그인 성공")
            return .success(true)
        } else {
            print("❌ 로그인 실패: 잘못된 자격 증명")
            return .failure(AuthError.invalidCredentials)
        }
    }
    
    public func logout() {
        print("👋 로그아웃 처리")
        loggedIn = false
    }
    
    public func isLoggedIn() -> Bool {
        return loggedIn
    }
}
