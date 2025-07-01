//
//  HomeViewModel.swift
//  Feature
//
//  Created by 이지훈 on 6/30/25.
//

import SwiftUI
import Combine
import Core
import Domain

public final class HomeViewModel: ObservableObject {
    @Published public var userName: String = ""
    @Published public var isLoading: Bool = false
    
    // Property Wrapper로 의존성 자동 주입
    @Dependency private var getCurrentUserUseCase: GetCurrentUserUseCaseProtocol
    
    private var cancellables = Set<AnyCancellable>()
    
    public init() {
        print("🏠 HomeViewModel 생성 (Property Wrapper 방식)")
        loadUserData()
    }
    
    private func loadUserData() {
        isLoading = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self = self else { return }
            
            if let user = self.getCurrentUserUseCase.execute() {
                self.userName = user.name
                print("👤 사용자 데이터 로드 완료: \(user.name)")
            }
            self.isLoading = false
        }
    }
    
    public func refreshUserData() {
        print("🔄 사용자 데이터 새로고침")
        loadUserData()
    }
}
