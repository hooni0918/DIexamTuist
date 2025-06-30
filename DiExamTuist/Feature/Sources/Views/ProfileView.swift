//
//  ProfileView.swift
//  Feature
//
//  Created by 이지훈 on 6/30/25.
//

import SwiftUI

public struct ProfileView: View {
    @StateObject private var viewModel: ProfileViewModel
    private let router: any Router
    
    // MARK: - 생성자 (의존성 주입)
    public init(viewModel: ProfileViewModel, router: any Router) {
        print("👤 ProfileView 초기화 시작")
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.router = router
        print("✅ ProfileView 초기화 완료")
    }
    
    public var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "person.circle.fill")
                .font(.system(size: 80))
                .foregroundColor(.blue)
            
            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            } else if let user = viewModel.user {
                VStack(spacing: 10) {
                    Text(user.name)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text(user.email)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
            }
            
            VStack(spacing: 15) {
                Button(action: {
                    print("🚪 로그아웃 요청")
                    viewModel.logout()
                }) {
                    HStack {
                        Image(systemName: "arrow.right.square")
                        Text("로그아웃")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                
                Button(action: {
                    print("⬅️ 뒤로가기 요청")
                    router.goBack()
                }) {
                    HStack {
                        Image(systemName: "arrow.left")
                        Text("뒤로가기")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
            .padding(.top, 30)
        }
        .padding()
        .navigationTitle("프로필")
    }
}
