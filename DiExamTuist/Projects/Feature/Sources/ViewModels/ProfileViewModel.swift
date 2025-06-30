//
//  ProfileViewModel.swift
//  Feature
//
//  Created by 이지훈 on 6/30/25.
//

import Foundation
import SwiftUI
import Domain

// MARK: - Profile View Model
public class ProfileViewModel: ObservableObject {
    @Published public var user: User?
    @Published public var isLoading: Bool = false
    
    private let getCurrentUserUseCase: GetCurrentUserUseCase
    private let logoutUseCase: LogoutUseCase
    private let router: any Router
    
    public init(getCurrentUserUseCase: GetCurrentUserUseCase,
         logoutUseCase: LogoutUseCase,
         router: any Router) {
        self.getCurrentUserUseCase = getCurrentUserUseCase
        self.logoutUseCase = logoutUseCase
        self.router = router
        loadProfile()
    }
    
    private func loadProfile() {
        isLoading = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            guard let self = self else { return }
            
            self.user = self.getCurrentUserUseCase.execute()
            self.isLoading = false
        }
    }
    
    public func logout() {
        logoutUseCase.execute()
        router.navigate(to: .login)
    }
    
    public func goBack() {
        router.goBack()
    }
}
