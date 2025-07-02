//
//  HomeView.swift
//  HomeFeature
//
//  Created by 이지훈 on 7/1/25.
//

import SwiftUI
import Core
import HomeDomain

public struct HomeView: View {
    @Environment(HomeCoordinator.self) var coordinator
    @State private var viewModel = HomeViewModel()
    
    public init() {
        print("🏠 HomeView 초기화")
    }
    
    public var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "house.fill")
                .font(.system(size: 60))
                .foregroundColor(.blue)
            
            if viewModel.isLoading {
                ProgressView()
            } else {
                Text("안녕하세요, \(viewModel.userName)님!")
                    .font(.title2)
                    .fontWeight(.semibold)
            }
            
            Text("레퍼런스 방식: Feature가 Mock 데이터 관리")
                .font(.body)
                .foregroundColor(.secondary)
            
            VStack(spacing: 15) {
                Button("설정") {
                    coordinator.push(.settings)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                Button("사용자 정보") {
                    coordinator.sheet(.userInfo)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                Button("새로고침") {
                    viewModel.refreshUser()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.orange)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
        .padding()
        .navigationTitle("홈")
    }
}
