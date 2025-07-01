//
//  LoginViewModel.swift
//  Feature
//
//  Created by 이지훈 on 6/30/25.
//

import Core
import SwiftUI
import Combine
import Domain

public final class LoginViewModel: ObservableObject {
    @Published public var email: String = ""
    @Published public var password: String = ""
    @Published public var isLoading: Bool = false
    @Published public var errorMessage: String = ""
    
    // Property Wrapper로 의존성 자동 주입
    @Dependency private var loginUseCase: LoginUseCaseProtocol
    
    public init() {
        print("🔐 LoginViewModel 생성 (Property Wrapper 방식)")
    }
    
    @MainActor
    public func login() async {
        isLoading = true
        errorMessage = ""
        
        let result = await loginUseCase.execute(email: email, password: password)
        
        switch result {
        case .success(let success):
            if success {
                print("✅ 로그인 성공")
            } else {
                errorMessage = "로그인에 실패했습니다."
            }
        case .failure(let error):
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
}
