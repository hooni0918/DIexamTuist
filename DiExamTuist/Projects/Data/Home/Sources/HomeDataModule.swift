//
//  HomeDataModule.swift
//  HomeData
//
//  Created by 이지훈 on 7/2/25.
//


import Foundation
import Core
import HomeDomain

// ✅ 미래 마이그레이션을 위한 Data Module Registry
public struct HomeDataModule {
    
    /// Feature에서 Data 모듈 사용 시 이 메서드 호출
    /// App은 이 과정을 전혀 모름!
    public static func configure() {
        print("🏠 HomeDataModule 등록 시작 (Feature → Data 마이그레이션)")
        
        // Repository 등록
        DIContainer.shared.register(HomeRepository.self, scope: .container) { _ in
            return HomeRepositoryImpl()
        }
        
        // UseCase 등록
        DIContainer.shared.register(GetCurrentUserUseCaseProtocol.self, scope: .graph) { resolver in
            let repository = resolver.resolve(HomeRepository.self)
            return GetCurrentUserUseCase(homeRepository: repository)
        }
        
        print("✅ HomeDataModule 등록 완료 - 실제 API 연동 준비됨")
    }
}

/*
마이그레이션 방법:

1. HomeFeature/Project.swift에 HomeData 의존성 추가:
   dependencies: [
       .project(target: "HomeData", path: "../../Data/Home"),
   ]

2. HomeFeature/HomeViewModel.swift 수정:
   // Mock 데이터 제거
   // @Dependency private var getCurrentUserUseCase: GetCurrentUserUseCaseProtocol 추가

3. HomeFeature 초기화 시:
   HomeDataModule.configure() 호출

→ App은 변경 없음, Feature만 수정!
*/
