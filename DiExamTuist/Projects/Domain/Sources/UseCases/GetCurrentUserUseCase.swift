//
//  GetCurrentUserUseCase.swift
//  Domain
//
//  Created by 이지훈 on 6/30/25.
//

import Foundation

// MARK: - Get Current User Use Case
public protocol GetCurrentUserUseCase {
    func execute() -> User?
}

public class GetCurrentUserUseCaseImpl: GetCurrentUserUseCase {
    private let userRepository: UserRepository
    
    public init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    public func execute() -> User? {
        return userRepository.getCurrentUser()
    }
}
