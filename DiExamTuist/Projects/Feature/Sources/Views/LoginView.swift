//
//  LoginView.swift
//  Feature
//
//  Created by 이지훈 on 6/30/25.
//

import SwiftUI

public struct LoginView: View {
    @Environment(AppCoordinator.self) var coordinator
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
        }
        .padding()
        .navigationTitle("로그인")
    }
    
    private func performLogin() async {
        await viewModel.login()
        
        if viewModel.errorMessage.isEmpty && !viewModel.isLoading {
            coordinator.push(.home)
        }
    }
}
