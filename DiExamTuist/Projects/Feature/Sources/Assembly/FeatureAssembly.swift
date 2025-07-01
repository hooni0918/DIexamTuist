//
//  FeatureAssembly.swift
//  Feature
//
//  Created by 이지훈 on 7/1/25.
//

import Foundation
import Core
import Data
import Domain

// MARK: - Feature Assembly (전체 조립)
public struct FeatureAssembly {
    public static func configureAll() {
        print("🚀 FeatureAssembly - 모든 의존성 등록 시작")
        
        registerSharedObjects()
        registerRepositories()
        registerUseCases()
        
        print("✅ 모든 의존성 등록 완료")
    }
    
    /// Network, DB, Logger 등 공통사용 객체등록
    private static func registerSharedObjects() {
        let container = DIContainer.shared
        
        container.register(Logger.self, instance: Logger.shared)
        container.register(NetworkManager.self, instance: NetworkManager.shared)
        
        print("✅ 기본 의존성 등록 완료")
    }
    
    /// Repository 등록
    private static func registerRepositories() {
        let container = DIContainer.shared
        
        container.register(UserRepositoryProtocol.self, factory: {
            print("👤 UserRepository 등록")
            return UserRepository()
        })
        
        container.register(AuthRepositoryProtocol.self, factory: {
            print("🔐 AuthRepository 등록")
            return AuthRepository()
        })
        
        print("✅ Repository 등록 완료")
    }
    
    /// UseCase 등록
    private static func registerUseCases() {
        let container = DIContainer.shared
        
        container.register(GetCurrentUserUseCaseProtocol.self, factory: {
            print("📋 GetCurrentUserUseCase 등록")
            let userRepository = container.resolve(UserRepositoryProtocol.self)
            return GetCurrentUserUseCase(userRepository: userRepository)
        })
        
        container.register(LoginUseCaseProtocol.self, factory: {
            print("🔑 LoginUseCase 등록")
            let authRepository = container.resolve(AuthRepositoryProtocol.self)
            return LoginUseCase(authRepository: authRepository)
        })
        
        container.register(LogoutUseCaseProtocol.self, factory: {
            print("🚪 LogoutUseCase 등록")
            let authRepository = container.resolve(AuthRepositoryProtocol.self)
            return LogoutUseCase(authRepository: authRepository)
        })
        
        print("✅ UseCase 등록 완료")
    }
}
