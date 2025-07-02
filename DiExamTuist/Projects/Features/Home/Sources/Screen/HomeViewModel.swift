//
//  HomeViewModel.swift
//  HomeFeature
//
//  Created by 이지훈 on 7/2/25.
//

import Foundation
import HomeDomain
import HomeData
import Core

// MARK: - HomeViewModel: DI 방식 비교
@Observable
public final class HomeViewModel {
   public var userName: String = ""
   public var currentUser: User?
   public var allUsers: [User] = []
   public var isLoading: Bool = false
   public var errorMessage: String = ""
   
   // MARK: - 방식 1: @ObservationIgnored + @Dependency (권장)
   /*
    장점:
    - Property Wrapper의 편의성 활용 (자동 주입)
    - 타입 안전성 보장
    - 코드 간결성
    - DI Container의 생명주기 관리 활용
    
    단점:
    - @ObservationIgnored 추가 필요 (SwiftUI 관찰에서 제외)
    - 매크로 충돌 가능성 (향후 Swift 버전에서)
    
    동작 원리:
    - @Observable: SwiftUI 반응형 시스템을 위한 매크로
    - @Dependency: DI Container에서 자동 resolve하는 Property Wrapper
    - @ObservationIgnored: SwiftUI 관찰 대상에서 제외 (DI용 프로퍼티는 UI 변화 추적 불필요)
    - 컴파일 타임에 두 매크로가 같은 프로퍼티를 변환하려다 충돌 → @ObservationIgnored로 해결
    */
   @ObservationIgnored
   @Dependency private var getCurrentUserUseCase: GetCurrentUserUseCaseProtocol
   @ObservationIgnored
   @Dependency private var getAllUsersUseCase: GetAllUsersUseCaseProtocol
   @ObservationIgnored
   @Dependency private var switchUserUseCase: SwitchUserUseCaseProtocol
   
   // MARK: - 방식 2: 직접 resolve (현재 방식)
   /*
    장점:
    - @Observable과 충돌 없음
    - 명시적 의존성 관리 (init에서 한 번에 확인 가능)
    - Property Wrapper 매크로 문제 회피
    - 디버깅 용이 (resolve 시점 명확)
    
    단점:
    - 보일러플레이트 코드 증가
    - 수동 resolve 필요
    - init에서 모든 의존성 수동 관리
    
    동작 원리:
    - DIContainer.shared.resolve()로 수동 주입
    - private let으로 불변성 보장
    - @Observable이 이 프로퍼티들을 건드리지 않음 (let이므로)
    */
   private let getCurrentUserUseCaseManual: GetCurrentUserUseCaseProtocol
   private let getAllUsersUseCaseManual: GetAllUsersUseCaseProtocol
   private let switchUserUseCaseManual: SwitchUserUseCaseProtocol
   
   public init() {
       print("🏠 HomeViewModel 생성 - DI 방식 비교")
       
       // Data 모듈 활성화 (실제 구현체들을 DI Container에 등록)
       HomeDataModule.configure()
       
       // 방식 2: 수동 resolve (매크로 충돌 없는 안전한 방법)
       self.getCurrentUserUseCaseManual = DIContainer.shared.resolve(GetCurrentUserUseCaseProtocol.self)
       self.getAllUsersUseCaseManual = DIContainer.shared.resolve(GetAllUsersUseCaseProtocol.self)
       self.switchUserUseCaseManual = DIContainer.shared.resolve(SwitchUserUseCaseProtocol.self)
       
       // 초기 데이터 로드
       Task {
           await loadUserData()
           await loadAllUsers()
       }
   }
   
   // MARK: - 비즈니스 로직 (두 방식 모두 동일한 결과)
   @MainActor
   private func loadUserData() async {
       isLoading = true
       errorMessage = ""
       
       do {
           // 실제 사용 시에는 둘 중 하나만 선택
           // 현재는 비교를 위해 방식 2 사용
           let user = await Task.detached { [weak self] in
               return self?.getCurrentUserUseCaseManual.execute()
               // 방식 1을 사용한다면: self?.getCurrentUserUseCase.execute()
           }.value
           
           if let user = user {
               currentUser = user
               userName = user.name
               print("👤 사용자 데이터 로드 완료: \(user.name)")
           } else {
               errorMessage = "사용자 정보를 불러올 수 없습니다."
           }
       } catch {
           errorMessage = "데이터 로드 중 오류가 발생했습니다."
           print("❌ 데이터 로드 실패: \(error)")
       }
       
       isLoading = false
   }
   
   @MainActor
   private func loadAllUsers() async {
       let users = await Task.detached { [weak self] in
           return self?.getAllUsersUseCaseManual.execute() ?? []
           // 방식 1을 사용한다면: self?.getAllUsersUseCase.execute() ?? []
       }.value
       
       allUsers = users
       print("📋 전체 사용자 목록 로드: \(users.count)명")
   }
   
   @MainActor
   public func refreshUser() async {
       print("🔄 사용자 정보 새로고침")
       await loadUserData()
   }
   
   @MainActor
   public func switchUser(to user: User) async {
       isLoading = true
       
       await Task.detached { [weak self] in
           self?.switchUserUseCaseManual.execute(userId: user.id)
           // 방식 1을 사용한다면: self?.switchUserUseCase.execute(userId: user.id)
       }.value
       
       await loadUserData()
       print("✅ 사용자 전환 완료: \(user.name)")
   }
}

/*
MARK: - 매크로 충돌 상세 설명

@Observable 매크로가 하는 일:
```swift
// 원본
@Observable class HomeViewModel {
    var userName: String = ""
    @Dependency private var useCase: Protocol
}

// @Observable이 변환한 코드 (내부적으로)
class HomeViewModel {
    private var _userName: String = ""
    private var _useCase: ??? // 여기서 충돌!
    
    var userName: String {
        get { /* 관찰 추적 코드 */ return _userName }
        set { /* 관찰 추적 코드 */ _userName = newValue }
    }
}
*/
