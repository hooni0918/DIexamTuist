//
//  ViewModelFactory.swift 
//  Feature
//
//  Created by 이지훈 on 6/30/25.
//

import Foundation
import Domain

public class ViewModelFactory {
    private let diContainer: DIContainerProtocol
    
    public init() {
        print("🏭 ViewModelFactory 생성 시작")
        self.diContainer = DIContainer()
        print("📦 DIContainer 생성 완료")
    }
    
    public func makeHomeViewModel() -> HomeViewModel {
        print("🏠 HomeViewModel 생성 요청")
        
        print("📋 GetCurrentUserUseCase 의존성 해결 중...")
        let getCurrentUserUseCase = diContainer.resolve(GetCurrentUserUseCase.self)!
        
        print("🧭 Router 의존성 해결 중...")
        let router = diContainer.resolve((any Router).self)!
        
        print("✅ HomeViewModel 조립 완료")
        return HomeViewModel(
            getCurrentUserUseCase: getCurrentUserUseCase,
            router: router
        )
    }
    
    public func makeProfileViewModel() -> ProfileViewModel {
        print("👤 ProfileViewModel 생성 요청")
        
        let getCurrentUserUseCase = diContainer.resolve(GetCurrentUserUseCase.self)!
        let logoutUseCase = diContainer.resolve(LogoutUseCase.self)!
        let router = diContainer.resolve((any Router).self)!
        
        print("✅ ProfileViewModel 조립 완료")
        return ProfileViewModel(
            getCurrentUserUseCase: getCurrentUserUseCase,
            logoutUseCase: logoutUseCase,
            router: router
        )
    }
    
    public func makeLoginViewModel() -> LoginViewModel {
        print("🔐 LoginViewModel 생성 요청")
        
        let loginUseCase = diContainer.resolve(LoginUseCase.self)!
        let router = diContainer.resolve((any Router).self)!
        
        print("✅ LoginViewModel 조립 완료")
        return LoginViewModel(
            loginUseCase: loginUseCase,
            router: router
        )
    }
    
    public func getRouter() -> any Router {
        print("🧭 Router 요청")
        return diContainer.resolve((any Router).self)!
    }
}
