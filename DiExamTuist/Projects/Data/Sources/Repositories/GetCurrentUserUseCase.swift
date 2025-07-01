//
//  GetCurrentUserUseCase.swift
//  Data
//
//  Created by 이지훈 on 7/1/25.
//

import Foundation
import Domain

public final class GetCurrentUserUseCase: GetCurrentUserUseCaseProtocol {
    private let userRepository: UserRepositoryProtocol
    
    public init(userRepository: UserRepositoryProtocol) {
        self.userRepository = userRepository
        print("📋 GetCurrentUserUseCase 생성")
    }
    
    public func execute() -> User? {
        print("👤 현재 사용자 정보 조회")
        return userRepository.getCurrentUser()
    }
}
