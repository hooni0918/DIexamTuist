//
//  LoginView.swift
//  Feature
//
//  Created by 이지훈 on 6/30/25.
//

import SwiftUI

public struct LoginView: View {
    @StateObject private var viewModel: LoginViewModel
    private let router: any Router
    
    // MARK: - 생성자 (의존성 주입)
    public init(viewModel: LoginViewModel, router: any Router) {
        print("🔐 LoginView 초기화 시작")
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.router = router
        print("✅ LoginView 초기화 완료")
    }
    
    public var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "person.badge.key.fill")
                .font(.system(size: 60))
                .foregroundColor(.orange)
            
            Text("로그인")
                .font(.title)
                .fontWeight(.bold)
            
            VStack(spacing: 15) {
                TextField("이메일", text: $viewModel.email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                
                SecureField("비밀번호", text: $viewModel.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            if !viewModel.errorMessage.isEmpty {
                Text(viewModel.errorMessage)
                    .foregroundColor(.red)
                    .font(.caption)
            }
            
            Button(action: {
                Task {
                    print("🔑 로그인 시도 시작")
                    await performLogin()
                }
            }) {
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                } else {
                    Text("로그인")
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(viewModel.isLoading ? Color.gray : Color.orange)
            .foregroundColor(.white)
            .cornerRadius(10)
            .disabled(viewModel.isLoading)
        }
        .padding()
        .navigationTitle("로그인")
    }
    
    private func performLogin() async {
        await viewModel.login()
        
        // 로그인 성공시 화면 전환
        if viewModel.errorMessage.isEmpty && !viewModel.isLoading {
            print("✅ 로그인 성공 - 홈으로 이동")
            router.navigate(to: .home)
        } else {
            print("❌ 로그인 실패: \(viewModel.errorMessage)")
        }
    }
}
