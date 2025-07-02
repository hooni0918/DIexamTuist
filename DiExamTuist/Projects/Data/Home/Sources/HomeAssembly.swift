//
//  HomeAssembly.swift
//  HomeData
//
//  Created by 이지훈 on 7/1/25.
//

import Foundation
import Swinject
import Core
import HomeDomain

public struct HomeAssembly: Assembly {
    public init() {}
    
    public func assemble(container: Container) {
        print("🏠 HomeAssembly 등록 시작")
        
        container.register(HomeRepository.self) { _ in
            print("👤 HomeRepository 생성")
            return HomeRepositoryImpl()
        }.inObjectScope(.container)
        
        container.register(GetCurrentUserUseCaseProtocol.self) { resolver in
            print("📋 GetCurrentUserUseCase 생성")
            let repository = resolver.resolve(HomeRepository.self)!
            return GetCurrentUserUseCase(homeRepository: repository)
        }.inObjectScope(.graph)
        
        print("✅ HomeAssembly 등록 완료")
    }
}
