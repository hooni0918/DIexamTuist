//
//  CoordinatorFactory.swift
//  App
//
//  Created by 이지훈 on 7/1/25.
//

import SwiftUI
import HomeFeature
import LoginFeature
import ProfileFeature

@MainActor
struct CoordinatorFactory {
   
   init() {}
   
   var homeCoordinatorRootView: some View {
       let coordinator = HomeCoordinator()
       return HomeCoordinatorView()
           .environment(coordinator)
   }
   
   var loginCoordinatorRootView: some View {
       let coordinator = LoginCoordinator()
       return LoginCoordinatorView()
           .environment(coordinator)
   }
   
   var profileCoordinatorRootView: some View {
       let coordinator = ProfileCoordinator()
       return ProfileCoordinatorView()
           .environment(coordinator)
   }
}
