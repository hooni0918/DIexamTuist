//
//  ProfileViewModel.swift
//  Feature
//
//  Created by 이지훈 on 6/30/25.
//

import SwiftUI
import Core
import Domain

public final class ProfileViewModel: ObservableObject {
    @Published public var user: User?
    @Published public var isLoading: Bool = false
    @Published public var showLogoutAlert: Bool = false
    
    @Dependency private var getCurrentUserUseCase: GetCurrentUserUseCaseProtocol
    @Dependency private var logoutUseCase: LogoutUseCaseProtocol
    
    public init() {
        print("👤 ProfileViewModel 생성 (Property Wrapper 방식)")
        loadProfile()
    }
    
    private func loadProfile() {
        isLoading = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            guard let self = self else { return }
            
            self.user = self.getCurrentUserUseCase.execute()
            self.isLoading = false
            
            if let user = self.user {
                print("👤 프로필 로드 완료: \(user.name)")
            }
        }
    }
    
    public func requestLogout() {
        print("🚪 로그아웃 요청")
        showLogoutAlert = true
    }
    
    public func confirmLogout() {
        print("✅ 로그아웃 확인")
        logoutUseCase.execute()
        showLogoutAlert = false
    }
    
    public func cancelLogout() {
        print("❌ 로그아웃 취소")
        showLogoutAlert = false
    }
}
