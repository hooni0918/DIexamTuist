//
//  LoginView.swift
//  Feature
//
//  Created by 이지훈 on 7/1/25.
//

import SwiftUI

public struct LoginView: View {
    @Environment(LoginCoordinator.self) var coordinator
    @StateObject private var viewModel = LoginViewModel()
    
    public init() {
        print("🔐 LoginView 초기화")
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
            
            VStack(spacing: 10) {
                Button(action: {
                    Task {
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
                
                HStack(spacing: 20) {
                    Button("회원가입") {
                        coordinator.push(.signUp)
                    }
                    .foregroundColor(.blue)
                    
                    Button("비밀번호 찾기") {
                        coordinator.push(.forgotPassword)
                    }
                    .foregroundColor(.blue)
                }
                
                Button("이용약관") {
                    coordinator.sheet(.terms)
                }
                .foregroundColor(.gray)
                .font(.caption)
            }
        }
        .padding()
        .navigationTitle("로그인")
    }
    
    private func performLogin() async {
        await viewModel.login()
        
        if viewModel.errorMessage.isEmpty && !viewModel.isLoading {
            // 로그인 성공 시 처리
            print("✅ 로그인 성공")
        }
    }
}

// MARK: - Sign Up View
struct SignUpView: View {
    @Environment(LoginCoordinator.self) var coordinator
    
    var body: some View {
        VStack(spacing: 20) {
            Text("회원가입")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("회원가입 기능을 구현해주세요")
                .foregroundColor(.secondary)
            
            Button("완료") {
                coordinator.pop()
            }
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
        .navigationTitle("회원가입")
    }
}

// MARK: - Forgot Password View
struct ForgotPasswordView: View {
    @Environment(LoginCoordinator.self) var coordinator
    
    var body: some View {
        VStack(spacing: 20) {
            Text("비밀번호 찾기")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("비밀번호 찾기 기능을 구현해주세요")
                .foregroundColor(.secondary)
            
            Button("완료") {
                coordinator.pop()
            }
            .padding()
            .background(Color.orange)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
        .navigationTitle("비밀번호 찾기")
    }
}

// MARK: - Terms of Service View
struct TermsOfServiceView: View {
    @Environment(LoginCoordinator.self) var coordinator
    
    var body: some View {
        VStack(spacing: 20) {
            Text("이용약관")
                .font(.title)
                .fontWeight(.bold)
            
            ScrollView {
                Text("여기에 이용약관 내용이 들어갑니다...")
                    .padding()
            }
            
            Button("확인") {
                coordinator.dismissSheet()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }
}

