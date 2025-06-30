//
//  LoginViewModel.swift
//  Feature
//
//  Created by 이지훈 on 6/30/25.
//

import Foundation
import SwiftUI
import Domain

// MARK: - Login View Model (Presentation Layer)
public class LoginViewModel: ObservableObject {
    @Published public var email: String = ""
    @Published public var password: String = ""
    @Published public var isLoading: Bool = false
    @Published public var errorMessage: String = ""
    
    private let loginUseCase: LoginUseCase
    private let router: any Router
    
    public init(loginUseCase: LoginUseCase, router: any Router) {
        self.loginUseCase = loginUseCase
        self.router = router
    }
    
    @MainActor
    public func login() async {
        isLoading = true
        errorMessage = ""
        
        let result = await loginUseCase.execute(email: email, password: password)
        
        switch result {
        case .success(let success):
            if success {
                router.navigate(to: .home)
            } else {
                errorMessage = "로그인에 실패했습니다."
            }
        case .failure(let error):
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
}
