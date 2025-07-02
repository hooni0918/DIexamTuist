//
//  LoginAssembly.swift
//  LoginData
//
//  Created by 이지훈 on 7/1/25.
//

import Foundation
import Swinject
import Core
import LoginDomain

public struct LoginAssembly: Assembly {
    public init() {}
    
    public func assemble(container: Container) {
        print("🔐 LoginAssembly 등록 시작")
        
        container.register(AuthRepository.self) { _ in
            return AuthRepositoryImpl()
        }.inObjectScope(.container)
        
        container.register(LoginUseCaseProtocol.self) { resolver in
            let repository = resolver.resolve(AuthRepository.self)!
            return LoginUseCase(authRepository: repository)
        }.inObjectScope(.graph)
        
        container.register(LogoutUseCaseProtocol.self) { resolver in
            let repository = resolver.resolve(AuthRepository.self)!
            return LogoutUseCase(authRepository: repository)
        }.inObjectScope(.graph)
        
        print("✅ LoginAssembly 등록 완료")
    }
}
