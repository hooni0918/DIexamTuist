//
//  DIContainerKey.swift
//  Feature
//
//  Created by 이지훈 on 6/30/25.
//

import SwiftUI

// MARK: - Environment Key for DI Container
public struct DIContainerKey: EnvironmentKey {
    public static let defaultValue: DIContainerProtocol = DIContainer()
}

// MARK: - Environment Values Extension
public extension EnvironmentValues {
    var diContainer: DIContainerProtocol {
        get { self[DIContainerKey.self] }
        set { self[DIContainerKey.self] = newValue }
    }
}
