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

// MARK: - HomeViewModel: @ObservationIgnored + @Dependency 방식
@Observable
public final class HomeViewModel {
   public var userName: String = ""
   public var currentUser: User?
   public var allUsers: [User] = []
   public var isLoading: Bool = false
   public var errorMessage: String = ""
   
   // MARK: - 방식 1: @ObservationIgnored + @Dependency (현재 사용 중)
   /*
    장점:
    - Property Wrapper의 편의성 활용 (자동 주입)
    - 타입 안전성 보장
    - 코드 간결성
    - DI Container의 생명주기 관리 활용
    - 지연 로딩으로 초기화 순서 문제 해결
    
    단점:
    - @ObservationIgnored 추가 필요 (SwiftUI 관찰에서 제외)
    - 매크로 충돌 가능성 (향후 Swift 버전에서)
    
    동작 원리:
    - @Observable: SwiftUI 반응형 시스템을 위한 매크로
    - @Dependency: DI Container에서 지연 로딩으로 resolve하는 Property Wrapper
    - @ObservationIgnored: SwiftUI 관찰 대상에서 제외 (DI용 프로퍼티는 UI 변화 추적 불필요)
    - 컴파일 타임에 두 매크로가 같은 프로퍼티를 변환하려다 충돌 → @ObservationIgnored로 해결
    - 지연 로딩: 실제 사용 시점에 resolve하여 초기화 순서 문제 해결
    */
   @ObservationIgnored
   @Dependency private var getCurrentUserUseCase: GetCurrentUserUseCaseProtocol
   @ObservationIgnored
   @Dependency private var getAllUsersUseCase: GetAllUsersUseCaseProtocol
   @ObservationIgnored
   @Dependency private var switchUserUseCase: SwitchUserUseCaseProtocol
   
   public init() {
       print("🏠 HomeViewModel 생성 - 지연 의존성 주입 방식")
       
       // Data 모듈 활성화 (실제 구현체들을 DI Container에 등록)
       // 이 시점에서 @Dependency들은 아직 resolve되지 않음 (지연 로딩)
       HomeDataModule.configure()
       
       // 초기 데이터 로드 (실제 UseCase 사용 시점에 resolve 발생)
       Task {
           await loadUserData()
           await loadAllUsers()
       }
   }
   
   // MARK: - 비즈니스 로직
   @MainActor
   private func loadUserData() async {
       isLoading = true
       errorMessage = ""
       
       do {
           // 이 시점에서 getCurrentUserUseCase가 처음 접근되어 resolve 발생
           let user = await Task.detached { [weak self] in
               return self?.getCurrentUserUseCase.execute()
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
       // getAllUsersUseCase 첫 접근 시 resolve 발생
       let users = await Task.detached { [weak self] in
           return self?.getAllUsersUseCase.execute() ?? []
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
       
       // switchUserUseCase 첫 접근 시 resolve 발생
       await Task.detached { [weak self] in
           self?.switchUserUseCase.execute(userId: user.id)
       }.value
       
       await loadUserData()
       print("✅ 사용자 전환 완료: \(user.name)")
   }
}

/*
 MARK: - 방식 2: 직접 resolve (대안)
 만약 방식 2를 사용했다면:
 
 // private let getCurrentUserUseCaseManual: GetCurrentUserUseCaseProtocol
 // private let getAllUsersUseCaseManual: GetAllUsersUseCaseProtocol
 // private let switchUserUseCaseManual: SwitchUserUseCaseProtocol
 
 // init() {
 //     HomeDataModule.configure()
 //     self.getCurrentUserUseCaseManual = DIContainer.shared.resolve(GetCurrentUserUseCaseProtocol.self)
 //     self.getAllUsersUseCaseManual = DIContainer.shared.resolve(GetAllUsersUseCaseProtocol.self)
 //     self.switchUserUseCaseManual = DIContainer.shared.resolve(SwitchUserUseCaseProtocol.self)
 // }
 
 장점: @Observable과 충돌 없음, 명시적 의존성 관리, 초기화 시점 명확
 단점: 보일러플레이트 코드 증가, 수동 resolve 필요
 
 MARK: - 지연 로딩 @Dependency 동작 원리
 
 기존 @Dependency 문제:
 ```swift
 @propertyWrapper
 public class Dependency<T> {
 public let wrappedValue: T
 
 public init() {
 // 초기화 시점에 바로 resolve → 등록 전이라 에러!
 self.wrappedValue = DIContainer.shared.resolve(T.self)
 }
 }
 */
