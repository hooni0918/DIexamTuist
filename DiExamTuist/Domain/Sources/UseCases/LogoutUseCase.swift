//
//  LogoutUseCase.swift
//  Domain
//
//  Created by 이지훈 on 6/30/25.
//

import Foundation

// MARK: - Logout Use Case (Domain Layer)
public protocol LogoutUseCase {
    func execute()
}

public class LogoutUseCaseImpl: LogoutUseCase {
    private let authRepository: AuthRepository
    
    public init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
    
    public func execute() {
        authRepository.logout()
    }
}
