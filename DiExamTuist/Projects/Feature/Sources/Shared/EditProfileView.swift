//
//  EditProfileView.swift
//  Feature
//
//  Created by 이지훈 on 7/1/25.
//


//
//  SharedViews.swift
//  Feature
//
//  Created by 이지훈 on 7/1/25.
//

import SwiftUI

// MARK: - Profile Edit View
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

// MARK: - Logout Confirm View
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
                    // 로그아웃 로직 수행
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

// MARK: - Settings View (Home에서 사용)
struct SettingsView: View {
    @Environment(HomeCoordinator.self) var coordinator
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "gearshape.fill")
                .font(.system(size: 50))
                .foregroundColor(.blue)
            
            Text("설정")
                .font(.title)
                .fontWeight(.bold)
            
            Text("앱 설정을 관리하세요")
                .font(.body)
                .foregroundColor(.secondary)
            
            VStack(spacing: 15) {
                SettingRow(title: "알림 설정", icon: "bell")
                SettingRow(title: "테마 설정", icon: "paintbrush")
                SettingRow(title: "언어 설정", icon: "globe")
                SettingRow(title: "개인정보 설정", icon: "lock")
            }
            
            Spacer()
            
            Button("뒤로가기") {
                coordinator.pop()
            }
            .padding()
            .background(Color.gray)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
        .navigationTitle("설정")
    }
}

struct SettingRow: View {
    let title: String
    let icon: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .frame(width: 30)
            
            Text(title)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
}

// MARK: - Tutorial View (Home에서 사용)
struct TutorialView: View {
    @Environment(HomeCoordinator.self) var coordinator
    
    var body: some View {
        VStack(spacing: 30) {
            Text("앱 튜토리얼")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            VStack(spacing: 20) {
                TutorialStep(
                    number: "1",
                    title: "홈 화면",
                    description: "메인 기능들을 확인할 수 있습니다"
                )
                
                TutorialStep(
                    number: "2",
                    title: "네비게이션",
                    description: "화면 간 이동이 가능합니다"
                )
                
                TutorialStep(
                    number: "3",
                    title: "설정",
                    description: "앱 설정을 변경할 수 있습니다"
                )
            }
            
            Spacer()
            
            Button("튜토리얼 완료") {
                coordinator.dismissCover()
            }
            .padding()
            .background(Color.purple)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.purple.opacity(0.1))
        .padding()
    }
}

struct TutorialStep: View {
    let number: String
    let title: String
    let description: String
    
    var body: some View {
        HStack {
            Text(number)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(width: 40, height: 40)
                .background(Color.purple)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Text(description)
                    .font(.body)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}