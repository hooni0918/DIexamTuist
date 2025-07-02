//
//  HomeViewModel.swift
//  HomeFeature
//
//  Created by 이지훈 on 7/2/25.
//

import Foundation
import HomeDomain
import Core

@Observable
public final class HomeViewModel {
    public var userName: String = ""
    public var currentUser: User?
    public var allUsers: [User] = []
    public var isLoading: Bool = false
    public var errorMessage: String = ""
    
    // ✅ HomeData의 "실제" 로직을 그대로 복사
    private let realUserDatabase: [User] = [
        User(id: "user_001", name: "이지훈", email: "jihoon.lee@company.com"),
        User(id: "user_002", name: "김개발", email: "dev.kim@company.com"),
        User(id: "user_003", name: "박디자인", email: "design.park@company.com"),
        User(id: "user_004", name: "최기획", email: "plan.choi@company.com"),
        User(id: "user_005", name: "정마케팅", email: "marketing.jung@company.com")
    ]
    
    private var currentUserId: String = "user_001"
    
    public init() {
        print("🏠 HomeViewModel 생성 - Login/Profile과 동일한 방식")
        
        Task {
            await loadUserData()
            await loadAllUsers()
        }
    }
    
    // ✅ Repository 로직을 직접 구현 (현재 HomeData와 동일)
    @MainActor
    private func loadUserData() async {
        isLoading = true
        errorMessage = ""
        
        print("🔍 현재 사용자 조회")
        
        // API 시뮬레이션 (HomeRepositoryImpl과 동일)
        try? await Task.sleep(nanoseconds: 500_000_000)
        
        let currentUser = realUserDatabase.first { $0.id == currentUserId }
        
        if let user = currentUser {
            self.currentUser = user
            userName = user.name
            print("✅ 사용자 조회 성공: \(user.name)")
        } else {
            errorMessage = "사용자 정보를 불러올 수 없습니다."
            print("❌ 사용자 조회 실패")
        }
        
        isLoading = false
    }
    
    @MainActor
    private func loadAllUsers() async {
        print("📋 전체 사용자 목록 조회")
        allUsers = realUserDatabase
    }
    
    @MainActor
    public func refreshUser() async {
        print("🔄 사용자 정보 새로고침")
        await loadUserData()
    }
    
    @MainActor
    public func switchUser(to user: User) async {
        isLoading = true
        
        print("🔄 사용자 전환: \(user.id)")
        
        // 전환 로직 (HomeRepositoryImpl과 동일)
        try? await Task.sleep(nanoseconds: 300_000_000)
        currentUserId = user.id
        
        await loadUserData()
        print("✅ 사용자 전환 완료: \(user.name)")
    }
}
