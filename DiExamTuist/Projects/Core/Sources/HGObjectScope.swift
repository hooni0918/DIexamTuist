//
//  DIContainer.swift
//  Core
//
//  Created by 이지훈 on 7/1/25.
//

import Foundation

// MARK: - 간단한 DI Container (Swinject 없이)
public final class DIContainer {
    public static let shared: DIContainer = DIContainer()
    private var services: [String: Any] = [:]
    
    private init() {
        print("📦 DIContainer 초기화")
    }
    
    public func resolve<T>(_ serviceType: T.Type) -> T {
        let key = String(describing: serviceType)
        guard let service = services[key] as? T else {
            fatalError("❌ \(serviceType) 타입을 해결할 수 없습니다. 등록되었는지 확인하세요.")
        }
        return service
    }
    
    // 팩토리 함수로 등록
    public func register<T>(_ serviceType: T.Type, factory: @escaping () -> T) {
        let key = String(describing: serviceType)
        services[key] = factory()
        print("✅ \(serviceType) 등록 완료")
    }
    
    // 인스턴스 직접 등록
    public func register<T>(_ serviceType: T.Type, instance: T) {
        let key = String(describing: serviceType)
        services[key] = instance
        print("✅ \(serviceType) 등록 완료")
    }
}

// MARK: - Property Wrapper for Dependency Injection
@propertyWrapper
public class Dependency<T> {
    public let wrappedValue: T
    
    public init() {
        self.wrappedValue = DIContainer.shared.resolve(T.self)
        print("🔌 \(T.self) 의존성 주입 완료")
    }
}
