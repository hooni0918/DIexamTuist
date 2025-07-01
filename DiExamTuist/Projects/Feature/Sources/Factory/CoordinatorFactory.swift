//
//  CoordinatorFactory.swift
//  Feature
//
//  Created by 이지훈 on 7/1/25.
//

import SwiftUI

@MainActor
public struct CoordinatorFactory {
    
    public init() {}
    
    public var homeCoordinatorRootView: some View {
        let coordinator = HomeCoordinator()
        return HomeCoordinatorView()
            .environment(coordinator)
    }
    
    public var profileCoordinatorRootView: some View {
        let coordinator = ProfileCoordinator()
        return ProfileCoordinatorView()
            .environment(coordinator)
    }
    
    public var loginCoordinatorRootView: some View {
        let coordinator = LoginCoordinator()
        return LoginCoordinatorView()
            .environment(coordinator)
    }
}
