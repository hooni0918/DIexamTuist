//
//  AuthRepositoryImpl.swift
//  Data
//
//  Created by 이지훈 on 6/30/25.
//

import Foundation
import Domain

public class AuthRepositoryImpl: AuthRepository {
    private var loggedIn = false
    
    public init() {}
    
    public func login(email: String, password: String) async -> Result<Bool, Error> {
        try? await Task.sleep(nanoseconds: 1_000_000_000) // 1초
        
        if !email.isEmpty && !password.isEmpty {
            loggedIn = true
            return .success(true)
        } else {
            return .failure(AuthError.invalidCredentials)
        }
    }
    
    public func logout() {
        loggedIn = false
    }
    
    public func isLoggedIn() -> Bool {
        return loggedIn
    }
}
