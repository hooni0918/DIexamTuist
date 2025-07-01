//
//  LoginUseCase.swift
//  Domain
//
//  Created by 이지훈 on 6/30/25.
//

import Foundation

// MARK: - Login Use Case
public protocol LoginUseCaseProtocol {
    func execute(email: String, password: String) async -> Result<Bool, Error>
}
