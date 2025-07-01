//
//  LogoutUseCase.swift
//  Data
//
//  Created by 이지훈 on 7/1/25.
//

import Foundation
import Domain

public final class LogoutUseCase: LogoutUseCaseProtocol {
    private let authRepository: AuthRepositoryProtocol
    
    public init(authRepository: AuthRepositoryProtocol) {
        self.authRepository = authRepository
        print("🚪 LogoutUseCase 생성")
    }
    
    public func execute() {
        print("👋 로그아웃 실행")
        authRepository.logout()
    }
}
