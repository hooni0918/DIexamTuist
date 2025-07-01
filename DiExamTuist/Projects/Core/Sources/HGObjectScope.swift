//
//  HGObjectScope.swift
//  Core
//
//  Created by 이지훈 on 7/1/25.
//


import Foundation
import Swinject

// MARK: - Object Scope Wrapper
public enum HGObjectScope {
    case graph
    case container
    case weak
    case transient
    
    var swinjectScope: ObjectScope {
        switch self {
        case .graph:
            return .graph
        case .container:
            return .container  
        case .weak:
            return .weak
        case .transient:
            return .transient
        }
    }
}

// MARK: - Shared DI Container
public final class DIContainer {
    public static let shared: DIContainer = DIContainer()
    private let container = Container()
    
    private init() {
        print("📦 DIContainer 초기화 (Property Wrapper 방식)")
    }
    
    public func resolve<T>(_ serviceType: T.Type) -> T {
        guard let resolved = container.resolve(serviceType) else {
            fatalError("❌ \(serviceType) 타입을 해결할 수 없습니다. 등록되었는지 확인하세요.")
        }
        return resolved
    }
    
    public func register<T>(
        _ serviceType: T.Type,
        scope: HGObjectScope = .graph,
        factory: @escaping (DIResolver) -> T
    ) {
        container.register(serviceType) { resolver in
            factory(DIResolver(resolver: resolver))
        }.inObjectScope(scope.swinjectScope)
        
        print("✅ \(serviceType) 등록 완료 (scope: \(scope))")
    }
    
    // MARK: - Assembly 등록 지원
    public func registerAssembly(assemblies: [any DIAssembly]) {
        assemblies.forEach { assembly in
            assembly.assemble(container: self)
        }
        print("🔧 Assembly 등록 완료: \(assemblies.count)개")
    }
}

// MARK: - Resolver Wrapper
public struct DIResolver {
    private let resolver: Resolver
    
    init(resolver: Resolver) {
        self.resolver = resolver
    }
    
    public func resolve<T>(_ serviceType: T.Type) -> T {
        guard let resolved = resolver.resolve(serviceType) else {
            fatalError("❌ \(serviceType) 타입을 해결할 수 없습니다.")
        }
        return resolved
    }
}

// MARK: - Assembly Protocol
public protocol DIAssembly {
    func assemble(container: DIContainer)
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
