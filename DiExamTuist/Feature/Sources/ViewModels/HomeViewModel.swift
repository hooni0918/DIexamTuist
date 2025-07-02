//
//  HomeViewModel.swift
//  Feature
//
//  Created by 이지훈 on 6/30/25.
//

import Foundation
import SwiftUI
import Combine
import Domain

public class HomeViewModel: ObservableObject {
    @Published public var userName: String = ""
    @Published public var isLoading: Bool = false
    
    private let getCurrentUserUseCase: GetCurrentUserUseCase
    private let router: any Router
    private var cancellables = Set<AnyCancellable>()
    
    public init(getCurrentUserUseCase: GetCurrentUserUseCase, router: any Router) {
        self.getCurrentUserUseCase = getCurrentUserUseCase
        self.router = router
        loadUserData()
    }
    
    private func loadUserData() {
        isLoading = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self = self else { return }
            
            if let user = self.getCurrentUserUseCase.execute() {
                self.userName = user.name
            }
            self.isLoading = false
        }
    }
    
    public func navigateToProfile() {
        router.navigate(to: .profile)
    }
    
    public func navigateToLogin() {
        router.navigate(to: .login)
    }
}
