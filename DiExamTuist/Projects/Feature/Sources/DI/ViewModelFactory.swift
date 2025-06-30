//
//  ViewModelFactory.swift 
//  Feature
//
//  Created by 이지훈 on 6/30/25.
//

import Foundation
import Domain

// MARK: - ViewModel Factory
public class ViewModelFactory {
    private let diContainer: DIContainerProtocol
    
    public init() {
        print("🏭 ViewModelFactory 생성 시작")
        self.diContainer = DIContainer()
        print("📦 DIContainer 생성 완료")
    }
    
    public func makeHomeViewModel() -> HomeViewModel {
        let getCurrentUserUseCase = diContainer.resolve(GetCurrentUserUseCase.self)!
        let router = diContainer.resolve((any Router).self)!
        
        return HomeViewModel(
            getCurrentUserUseCase: getCurrentUserUseCase,
            router: router
        )
    }
    
    public func makeProfileViewModel() -> ProfileViewModel {
        let getCurrentUserUseCase = diContainer.resolve(GetCurrentUserUseCase.self)!
        let logoutUseCase = diContainer.resolve(LogoutUseCase.self)!
        let router = diContainer.resolve((any Router).self)!
        
        return ProfileViewModel(
            getCurrentUserUseCase: getCurrentUserUseCase,
            logoutUseCase: logoutUseCase,
            router: router
        )
    }
    
    public func makeLoginViewModel() -> LoginViewModel {
        let loginUseCase = diContainer.resolve(LoginUseCase.self)!
        let router = diContainer.resolve((any Router).self)!
        
        return LoginViewModel(
            loginUseCase: loginUseCase,
            router: router
        )
    }
    
    public func getRouter() -> any Router {
        return diContainer.resolve((any Router).self)!
    }
}
