//
//  LoginViewModel.swift
//  LoginFeature
//
//  Created by 이지훈 on 7/1/25.
//

import Foundation
import LoginDomain

@Observable
public final class LoginViewModel {
    public var email: String = ""
    public var password: String = ""
    public var isLoading: Bool = false
    public var errorMessage: String = ""
    
    // ❌ DI 제거 - 레퍼런스 방식에서는 Mock 로직 사용
    // @Dependency private var loginUseCase: LoginUseCaseProtocol
    
    // ✅ Mock 사용자 계정들
    private let mockAccounts: [(email: String, password: String)] = [
        ("test@example.com", "password123"),
        ("user@test.com", "test123"),
        ("demo@demo.com", "demo123"),
        ("admin@admin.com", "admin123")
    ]
    
    public init() {
        print("🔐 LoginViewModel 생성 (레퍼런스 방식 - Mock 로직)")
    }
    
    @MainActor
    public func login() async {
        isLoading = true
        errorMessage = ""
        
        print("🔑 로그인 시도 (Mock): \(email)")
        
        // ✅ 실제 네트워크 호출 시뮬레이션
        try? await Task.sleep(nanoseconds: 1_500_000_000) // 1.5초 대기
        
        // Mock 로그인 검증
        let isValidAccount = mockAccounts.contains { account in
            account.email == email && account.password == password
        }
        
        if email.isEmpty || password.isEmpty {
            errorMessage = "이메일과 비밀번호를 모두 입력해주세요."
        } else if !isValidEmail(email) {
            errorMessage = "올바른 이메일 형식이 아닙니다."
        } else if isValidAccount {
            print("✅ 로그인 성공 (Mock)")
            // 성공 처리 - 실제 앱에서는 화면 전환 등
        } else {
            errorMessage = "이메일 또는 비밀번호가 올바르지 않습니다.\n\nMock 계정:\ntest@example.com / password123"
        }
        
        isLoading = false
    }
    
    // ✅ 나중에 Data 모듈 연동 시 이 메서드들만 수정하면 됨
    public func logout() {
        print("👋 로그아웃 (Mock)")
        email = ""
        password = ""
        errorMessage = ""
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}
