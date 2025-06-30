//
//  DIContainer.swift
//  Feature
//
//  Created by 이지훈 on 6/30/25.
//

import Foundation
import Swinject
import Domain
import Data

// MARK: - DI Container Protocol
public protocol DIContainerProtocol {
    func resolve<T>(_ type: T.Type) -> T?
}

// MARK: - DI Container
public class DIContainer: DIContainerProtocol {
    private let container = Container()
    
    public init() {
        setupDependencies()
    }
    
    public func resolve<T>(_ type: T.Type) -> T? {
        return container.resolve(type)
    }
    
    private func setupDependencies() {
        // MARK: - Data Layer
        container.register(UserRepository.self) { _ in
            UserRepositoryImpl()
        }
        
        container.register(AuthRepository.self) { _ in
            AuthRepositoryImpl()
        }
        
        // MARK: - Domain Layer
        container.register(GetCurrentUserUseCase.self) { resolver in
            GetCurrentUserUseCaseImpl(
                userRepository: resolver.resolve(UserRepository.self)!
            )
        }
        
        container.register(LoginUseCase.self) { resolver in
            LoginUseCaseImpl(
                authRepository: resolver.resolve(AuthRepository.self)!
            )
        }
        
        container.register(LogoutUseCase.self) { resolver in
            LogoutUseCaseImpl(
                authRepository: resolver.resolve(AuthRepository.self)!
            )
        }
        
        // MARK: - Router
        container.register((any Router).self) { _ in
            RouterImpl()
        }.inObjectScope(.container)
    }
}
