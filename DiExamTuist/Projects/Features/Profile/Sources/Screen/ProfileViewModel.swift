//
//  ProfileViewModel.swift
//  ProfileFeature
//
//  Created by 이지훈 on 7/1/25.
//

import Foundation
import ProfileDomain

@Observable
public final class ProfileViewModel {
    public var user: User?
    public var isLoading: Bool = false
    public var errorMessage: String = ""
    
    // @Dependency private var getUserUseCase: GetUserUseCaseProtocol
    
    private let mockProfiles: [User] = [
        User(id: "1", name: "이지훈", email: "jihoon@profile.com"),
        User(id: "2", name: "김개발", email: "dev@profile.com"),
        User(id: "3", name: "박디자인", email: "design@profile.com"),
        User(id: "4", name: "최기획", email: "plan@profile.com")
    ]
    
    public init() {
        print("👤 ProfileViewModel 생성 (레퍼런스 방식 - Mock 데이터)")
        loadProfile()
    }
    
    private func loadProfile() {
        isLoading = true
        errorMessage = ""
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) { [weak self] in
            guard let self = self else { return }
            
            self.user = self.mockProfiles.first
            self.isLoading = false
            
            if let user = self.user {
                print("👤 프로필 로드 완료 (Mock): \(user.name)")
            }
        }
    }
    
    public func updateProfile(name: String, email: String) {
        isLoading = true
        
        print("📝 프로필 업데이트 시도 (Mock): \(name), \(email)")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let self = self else { return }
            
            self.user = User(
                id: self.user?.id ?? "1",
                name: name,
                email: email
            )
            
            self.isLoading = false
            print("✅ 프로필 업데이트 완료 (Mock)")
        }
    }
    
    public func refreshProfile() {
        print("🔄 프로필 새로고침 (Mock)")
        loadProfile()
    }
    
    public func deleteAccount() {
        print("🗑️ 계정 삭제 요청 (Mock)")
        isLoading = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            self?.user = nil
            self?.isLoading = false
            print("✅ 계정 삭제 완료 (Mock)")
        }
    }
}
