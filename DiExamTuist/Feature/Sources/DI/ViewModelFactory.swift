//
//  ViewModelFactory.swift 
//  Feature
//
//  Created by 이지훈 on 6/30/25.
//

import Foundation
import Domain

// MARK: - ViewModel Factory (DI Container 캡슐화)
public class ViewModelFactory {
    private let diContainer: DIContainerProtocol
    
    // MARK: - 기본 생성자 (DIContainer 내부 생성)
    public init() {
        print("🏭 ViewModelFactory 생성 시작")
        self.diContainer = DIContainer()
        print("📦 DIContainer 생성 완료")
    }
    
    // MARK: - HomeViewModel 생성
    public func makeHomeViewModel() -> HomeViewModel {
        print("🏠 HomeViewModel 생성 요청")
        
        // DI Container에서 의존성 해결
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
    
    // MARK: - ProfileViewModel 생성
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
    
    // MARK: - LoginViewModel 생성
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
    
    // MARK: - Router 접근
    public func getRouter() -> any Router {
        print("🧭 Router 요청")
        return diContainer.resolve((any Router).self)!
    }
}
