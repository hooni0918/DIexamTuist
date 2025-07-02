//
//  ProfileAssembly.swift
//  ProfileData
//
//  Created by 이지훈 on 7/1/25.
//

import Foundation
import Swinject
import Core
import ProfileDomain

public struct ProfileAssembly: Assembly {
    public init() {}
    
    public func assemble(container: Container) {
        print("👤 ProfileAssembly 등록 시작")
        
        container.register(UserRepository.self) { _ in
            return UserRepositoryImpl()
        }.inObjectScope(.container)
        
        container.register(GetUserUseCaseProtocol.self) { resolver in
            let repository = resolver.resolve(UserRepository.self)!
            return GetUserUseCase(userRepository: repository)
        }.inObjectScope(.graph)
        
        container.register(UpdateUserUseCaseProtocol.self) { resolver in
            let repository = resolver.resolve(UserRepository.self)!
            return UpdateUserUseCase(userRepository: repository)
        }.inObjectScope(.graph)
        
        print("✅ ProfileAssembly 등록 완료")
    }
}
