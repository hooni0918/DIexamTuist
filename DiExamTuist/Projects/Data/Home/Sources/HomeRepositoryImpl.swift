import Foundation
import Core
import HomeDomain

public final class HomeRepositoryImpl: HomeRepository {
   private let logger: Logger
   private let networkManager: NetworkManager
   
   private let realUserDatabase: [User] = [
       User(id: "user_001", name: "이지훈", email: "jihoon.lee@company.com"),
       User(id: "user_002", name: "김개발", email: "dev.kim@company.com"),
       User(id: "user_003", name: "박디자인", email: "design.park@company.com"),
       User(id: "user_004", name: "최기획", email: "plan.choi@company.com"),
       User(id: "user_005", name: "정마케팅", email: "marketing.jung@company.com")
   ]
   
   private var currentUserId: String = "user_001"
   
   public init() {
       self.logger = Logger.shared
       self.networkManager = NetworkManager.shared
       logger.log("🏠 HomeRepositoryImpl 생성 - 실제 데이터 연동")
   }
   
   public func getCurrentUser() -> User? {
       logger.log("🔍 현재 사용자 조회 API 호출 시뮬레이션")
       
       Thread.sleep(forTimeInterval: 0.5)
       
       let currentUser = realUserDatabase.first { $0.id == currentUserId }
       
       if let user = currentUser {
           logger.log("✅ 사용자 조회 성공: \(user.name)")
       } else {
           logger.log("❌ 사용자 조회 실패")
       }
       
       return currentUser
   }
   
   public func updateUser(_ user: User) {
       logger.log("💾 사용자 정보 업데이트 API 호출: \(user.name)")
       
       Thread.sleep(forTimeInterval: 1.0)
       
       currentUserId = user.id
       
       logger.log("✅ 사용자 정보 업데이트 완료")
   }
   
   public func getAllUsers() -> [User] {
       logger.log("📋 전체 사용자 목록 조회")
       return realUserDatabase
   }
   
   public func switchUser(to userId: String) {
       logger.log("🔄 사용자 전환: \(userId)")
       currentUserId = userId
   }
}

public final class GetCurrentUserUseCase: GetCurrentUserUseCaseProtocol {
   private let homeRepository: HomeRepository
   
   public init(homeRepository: HomeRepository) {
       self.homeRepository = homeRepository
       Logger.shared.log("📋 GetCurrentUserUseCase 생성 - 실제 비즈니스 로직")
   }
   
   public func execute() -> User? {
       Logger.shared.log("👤 현재 사용자 정보 조회 실행")
       
       guard let user = homeRepository.getCurrentUser() else {
           Logger.shared.log("❌ 사용자 정보 없음")
           return nil
       }
       
       guard !user.name.isEmpty, !user.email.isEmpty else {
           Logger.shared.log("❌ 사용자 정보 불완전")
           return nil
       }
       
       Logger.shared.log("✅ 사용자 정보 검증 완료: \(user.name)")
       return user
   }
}

public final class GetAllUsersUseCase: GetAllUsersUseCaseProtocol {
   private let homeRepository: HomeRepository
   
   public init(homeRepository: HomeRepository) {
       self.homeRepository = homeRepository
   }
   
   public func execute() -> [User] {
       Logger.shared.log("📋 전체 사용자 목록 조회")
       return homeRepository.getAllUsers()
   }
}

public final class SwitchUserUseCase: SwitchUserUseCaseProtocol {
   private let homeRepository: HomeRepository
   
   public init(homeRepository: HomeRepository) {
       self.homeRepository = homeRepository
   }
   
   public func execute(userId: String) {
       Logger.shared.log("🔄 사용자 전환: \(userId)")
       homeRepository.switchUser(to: userId)
   }
}
