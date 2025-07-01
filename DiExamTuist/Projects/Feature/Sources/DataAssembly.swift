//
//  Projects/Feature/Sources/Assembly/FeatureAssembly.swift
//  새로운 Assembly Pattern
//

import SwiftUI
import Core
import Domain
import Data

// MARK: - Data Assembly
public struct DataAssembly: DIAssembly {
    public func assemble(container: DIContainer) {
        print("📦 DataAssembly - Repository 등록 시작")
        
        container.register(UserRepositoryProtocol.self) { _ in
            print("👤 UserRepository 등록")
            return UserRepository()
        }
        
        container.register(AuthRepositoryProtocol.self) { _ in
            print("🔐 AuthRepository 등록")
            return AuthRepository()
        }
        
        print("✅ Repository 등록 완료")
    }
}

// MARK: - Domain Assembly
public struct DomainAssembly: DIAssembly {
    public func assemble(container: DIContainer) {
        print("🎯 DomainAssembly - UseCase 등록 시작")
        
        container.register(GetCurrentUserUseCaseProtocol.self) { resolver in
            print("📋 GetCurrentUserUseCase 등록")
            return GetCurrentUserUseCase(
                userRepository: resolver.resolve(UserRepositoryProtocol.self)
            )
        }
        
        container.register(LoginUseCaseProtocol.self) { resolver in
            print("🔑 LoginUseCase 등록")
            return LoginUseCase(
                authRepository: resolver.resolve(AuthRepositoryProtocol.self)
            )
        }
        
        container.register(LogoutUseCaseProtocol.self) { resolver in
            print("🚪 LogoutUseCase 등록")
            return LogoutUseCase(
                authRepository: resolver.resolve(AuthRepositoryProtocol.self)
            )
        }
        
        print("✅ UseCase 등록 완료")
    }
}

// MARK: - Presentation Assembly
public struct PresentationAssembly: DIAssembly {
    public func assemble(container: DIContainer) {
        print("🧭 PresentationAssembly - Coordinator 등록 시작")
        
        container.register(AppCoordinator.self, scope: .container) { _ in
            print("🧭 AppCoordinator 등록 (싱글톤)")
            return MainActor.assumeIsolated {
                AppCoordinator()
            }
        }
        
        print("✅ Coordinator 등록 완료")
    }
}

// MARK: - Feature Assembly (전체 조립)
public struct FeatureAssembly {
    public static func configureAll() {
        print("🚀 FeatureAssembly - 모든 의존성 등록 시작")
        
        let container = DIContainer.shared
        
        let assemblies: [any DIAssembly] = [
            DataAssembly(),
            DomainAssembly(),
            PresentationAssembly()
        ]
        
        container.registerAssembly(assemblies: assemblies)
        
        print("✅ 모든 의존성 등록 완료")
    }
}
