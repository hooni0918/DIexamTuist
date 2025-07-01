//
//  User.swift
//  Domain/Entity
//
//  Tuist 모듈화 환경 - Domain 모듈
//

import Foundation

// MARK: - Domain Entity
public struct User {
    public let id: String
    public let name: String
    public let email: String
    
    public init(id: String, name: String, email: String) {
        self.id = id
        self.name = name
        self.email = email
    }
}

// MARK: - Auth Error Types
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
