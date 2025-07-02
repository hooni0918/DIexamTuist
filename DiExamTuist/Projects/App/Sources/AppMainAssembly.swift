//
//  AppMainAssembly.swift
//  App
//
//  Created by 이지훈 on 7/2/25.
//

import Foundation
import Swinject
import Core
import HomeDomain
import LoginDomain
import ProfileDomain

// ✅ App에서 Repository + UseCase 모든 것 등록
struct AppMainAssembly: Assembly {
    func assemble(container: Container) {
        print("🏗️ AppMainAssembly 등록 시작")
        
        // MARK: - Repository 등록
        container.register(HomeRepository.self) { _ in
            print("🏠 HomeRepository 구현체 생성")
            return HomeRepositoryImpl()
        }.inObjectScope(.container)
        
        container.register(UserRepository.self) { _ in
            print("👤 UserRepository 구현체 생성")
            return UserRepositoryImpl()
        }.inObjectScope(.container)
        
        container.register(AuthRepository.self) { _ in
            print("🔐 AuthRepository 구현체 생성")
            return AuthRepositoryImpl()
        }.inObjectScope(.container)
        
        // MARK: - UseCase 등록
        // Home UseCases
        container.register(GetCurrentUserUseCaseProtocol.self) { resolver in
            print("📋 GetCurrentUserUseCase 생성")
            let repository = resolver.resolve(HomeRepository.self)!
            return GetCurrentUserUseCase(homeRepository: repository)
        }.inObjectScope(.graph)
        
        // Profile UseCases
        container.register(GetUserUseCaseProtocol.self) { resolver in
            print("📋 GetUserUseCase 생성")
            let repository = resolver.resolve(UserRepository.self)!
            return GetUserUseCase(userRepository: repository)
        }.inObjectScope(.graph)
        
        container.register(UpdateUserUseCaseProtocol.self) { resolver in
            print("✏️ UpdateUserUseCase 생성")
            let repository = resolver.resolve(UserRepository.self)!
            return UpdateUserUseCase(userRepository: repository)
        }.inObjectScope(.graph)
        
        // Login UseCases
        container.register(LoginUseCaseProtocol.self) { resolver in
            print("🔑 LoginUseCase 생성")
            let repository = resolver.resolve(AuthRepository.self)!
            return LoginUseCase(authRepository: repository)
        }.inObjectScope(.graph)
        
        container.register(LogoutUseCaseProtocol.self) { resolver in
            print("🚪 LogoutUseCase 생성")
            let repository = resolver.resolve(AuthRepository.self)!
            return LogoutUseCase(authRepository: repository)
        }.inObjectScope(.graph)
        
        print("✅ AppMainAssembly 등록 완료")
    }
}
