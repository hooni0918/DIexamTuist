//
//  HomeViewModel.swift
//  HomeFeature
//
//  Created by 이지훈 on 7/2/25.
//

import Foundation
import HomeDomain

@Observable
public final class HomeViewModel {
    // ❌ @Published 제거 - @Observable과 충돌
    public var userName: String = ""
    public var isLoading: Bool = false
    
    // ✅ Mock 데이터 직접 관리
    private let mockUsers: [User] = [
        User(id: "1", name: "이지훈", email: "jihoon@home.com"),
        User(id: "2", name: "김철수", email: "chulsoo@home.com"),
        User(id: "3", name: "박영희", email: "younghee@home.com")
    ]
    
    public init() {
        print("🏠 HomeViewModel 생성 (레퍼런스 방식 - Mock 데이터)")
        loadUserData()
    }
    
    private func loadUserData() {
        isLoading = true
        
        // ✅ 실제 API 호출을 시뮬레이션
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) { [weak self] in
            guard let self = self else { return }
            
            // Mock 데이터에서 랜덤 선택
            let randomUser = self.mockUsers.randomElement()
            self.userName = randomUser?.name ?? "Unknown User"
            
            print("👤 사용자 데이터 로드 완료 (Mock): \(self.userName)")
            self.isLoading = false
        }
    }
    
    // ✅ 나중에 Data 모듈 연동 시 이 메서드만 수정하면 됨
    public func refreshUser() {
        print("🔄 사용자 정보 새로고침 (Mock)")
        loadUserData()
    }
}
