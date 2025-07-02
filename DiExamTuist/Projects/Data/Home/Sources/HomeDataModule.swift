import Foundation
import Core
import HomeDomain

public struct HomeDataModule {
   
   public static func configure() {
       print("🏠 HomeDataModule 등록 시작 - 실제 데이터 연동")
       
       DIContainer.shared.register(HomeRepository.self, scope: .container) { _ in
           return HomeRepositoryImpl()
       }
       
       DIContainer.shared.register(GetCurrentUserUseCaseProtocol.self, scope: .graph) { resolver in
           let repository = resolver.resolve(HomeRepository.self)
           return GetCurrentUserUseCase(homeRepository: repository)
       }
       
       DIContainer.shared.register(GetAllUsersUseCaseProtocol.self, scope: .graph) { resolver in
           let repository = resolver.resolve(HomeRepository.self)
           return GetAllUsersUseCase(homeRepository: repository)
       }
       
       DIContainer.shared.register(SwitchUserUseCaseProtocol.self, scope: .graph) { resolver in
           let repository = resolver.resolve(HomeRepository.self)
           return SwitchUserUseCase(homeRepository: repository)
       }
       
       print("✅ HomeDataModule 등록 완료 - 실제 API 연동 준비됨")
   }
}
