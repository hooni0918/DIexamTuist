//
//  LoginUseCase.swift
//  Domain
//
//  Created by 이지훈 on 6/30/25.
//

import Foundation

public protocol LoginUseCase {
    func execute(email: String, password: String) async -> Result<Bool, Error>
}

public class LoginUseCaseImpl: LoginUseCase {
    private let authRepository: AuthRepository
    
    public init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
    
    public func execute(email: String, password: String) async -> Result<Bool, Error> {
        return await authRepository.login(email: email, password: password)
    }
}
