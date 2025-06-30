//
//  HomeView.swift
//  Feature
//
//  Created by 이지훈 on 6/30/25.
//

import SwiftUI

public struct HomeView: View {
    @StateObject private var viewModel: HomeViewModel
    private let router: any Router
    
    // MARK: - 생성자 (의존성 주입)
    public init(viewModel: HomeViewModel, router: any Router) {
        print("🏠 HomeView 초기화 시작")
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.router = router
        print("✅ HomeView 초기화 완료")
    }
    
    public var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "house.fill")
                .font(.system(size: 60))
                .foregroundColor(.blue)
            
            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            } else {
                Text("안녕하세요, \(viewModel.userName)님!")
                    .font(.title2)
                    .fontWeight(.semibold)
            }
            
            Text("Factory Pattern 클린 아키텍처 앱입니다")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
            
            VStack(spacing: 15) {
                Button(action: {
                    print("🔄 프로필로 이동 요청")
                    router.navigate(to: .profile)
                }) {
                    HStack {
                        Image(systemName: "person.circle")
                        Text("프로필 보기")
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                
                Button(action: {
                    print("🔄 로그인으로 이동 요청")
                    router.navigate(to: .login)
                }) {
                    HStack {
                        Image(systemName: "person.badge.key")
                        Text("로그인")
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .padding()
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
            .padding(.top, 20)
        }
        .padding()
        .navigationTitle("홈")
    }
}
