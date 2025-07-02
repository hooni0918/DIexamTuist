//
//  GetCurrentUserUseCase.swift
//  App
//
//  Created by 이지훈 on 7/2/25.
//

import Foundation
import HomeDomain

public final class GetCurrentUserUseCase: GetCurrentUserUseCaseProtocol {
    private let homeRepository: HomeRepository
    
    public init(homeRepository: HomeRepository) {
        self.homeRepository = homeRepository
        print("📋 GetCurrentUserUseCase 생성 (App에서)")
    }
    
    public func execute() -> User? {
        print("👤 현재 사용자 정보 조회")
        return homeRepository.getCurrentUser()
    }
}
