//
//  LoginEntities.swift
//  LoginDomain
//
//  Created by 이지훈 on 7/1/25.
//

import Foundation

public enum AuthError: Error {
    case invalidCredentials
    case networkError
    case unknown
    
    public var localizedDescription: String {
        switch self {
        case .invalidCredentials:
            return "이메일 또는 비밀번호가 올바르지 않습니다."
        case .networkError:
            return "네트워크 오류가 발생했습니다."
        case .unknown:
            return "알 수 없는 오류가 발생했습니다."
        }
    }
}

public protocol AuthRepository {
    func login(email: String, password: String) async -> Result<Bool, Error>
    func logout()
    func isLoggedIn() -> Bool
}

public protocol LoginUseCaseProtocol {
    func execute(email: String, password: String) async -> Result<Bool, Error>
}

public protocol LogoutUseCaseProtocol {
    func execute()
}
