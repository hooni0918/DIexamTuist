//
//  AppDependencyConfiguration.swift
//  App
//
//  Created by 이지훈 on 7/1/25.
//

import Foundation
import Core
import HomeDomain
import LoginDomain
import ProfileDomain

/**
 Clean Architecture: App에서 Repository + UseCase 모든 것 등록
 Feature는 @Dependency로만 사용 (Data 모름)
*/

enum AppDependencyConfiguration {
    static func configure() {
        registerSharedObjects()
        
        DIContainer.shared.registerAssembly(
            assembly: [
                AppMainAssembly()
            ]
        )
        print("🔧 Clean Architecture DI 설정 완료")
    }
    
    /// Network, DB, 등 공통사용 객체등록
    private static func registerSharedObjects() {
        DIContainer.shared.register(Logger.self, scope: .container) { _ in
            print("📝 Logger 등록")
            return Logger.shared
        }
        
        DIContainer.shared.register(NetworkManager.self, scope: .container) { _ in
            print("🌐 NetworkManager 등록")
            return NetworkManager.shared
        }
        
        print("✅ 공통 객체 등록 완료")
    }
}
