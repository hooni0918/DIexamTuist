//
//  AuthError.swift
//  Data
//
//  Created by 이지훈 on 6/30/25.
//

import Foundation

// MARK: - Error Types
public enum AuthError: Error {
    case invalidCredentials
    case networkError
    
    public var localizedDescription: String {
        switch self {
        case .invalidCredentials:
            return "이메일 또는 비밀번호가 올바르지 않습니다."
        case .networkError:
            return "네트워크 오류가 발생했습니다."
        }
    }
}
