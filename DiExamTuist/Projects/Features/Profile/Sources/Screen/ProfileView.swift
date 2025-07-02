//
//  ProfileView.swift
//  ProfileFeature
//
//  Created by 이지훈 on 7/1/25.
//

import SwiftUI
import Core
import ProfileDomain
// ❌ ProfileData import 제거!

public struct ProfileView: View {
    @Environment(ProfileCoordinator.self) var coordinator
    @State private var viewModel = ProfileViewModel()
    
    public init() {
        print("👤 ProfileView 초기화")
    }
    
    public var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "person.circle.fill")
                .font(.system(size: 80))
                .foregroundColor(.blue)
            
            if viewModel.isLoading {
                ProgressView()
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
                    coordinator.push(.editProfile)
                }) {
                    HStack {
                        Image(systemName: "person.crop.circle.badge.plus")
                        Text("프로필 편집")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                
                Button(action: {
                    coordinator.sheet(.logout)
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
            }
            .padding(.top, 30)
        }
        .padding()
        .navigationTitle("프로필")
    }
}



struct EditProfileView: View {
    @Environment(ProfileCoordinator.self) var coordinator
    
    var body: some View {
        VStack(spacing: 20) {
            Text("프로필 편집")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("프로필 편집 기능을 구현해주세요")
                .foregroundColor(.secondary)
            
            Button("완료") {
                coordinator.pop()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
        .navigationTitle("프로필 편집")
    }
}

struct LogoutConfirmView: View {
    @Environment(ProfileCoordinator.self) var coordinator
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "questionmark.circle.fill")
                .font(.system(size: 50))
                .foregroundColor(.orange)
            
            Text("로그아웃")
                .font(.title)
                .fontWeight(.bold)
            
            Text("정말로 로그아웃 하시겠습니까?")
                .font(.body)
                .foregroundColor(.secondary)
            
            HStack(spacing: 20) {
                Button("취소") {
                    coordinator.dismissSheet()
                }
                .padding()
                .background(Color.gray)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                Button("로그아웃") {
                    coordinator.dismissSheet()
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
        .padding()
    }
}
