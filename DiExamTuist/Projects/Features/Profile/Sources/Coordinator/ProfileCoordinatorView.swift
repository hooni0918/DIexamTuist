//
//  ProfileCoordinatorView.swift
//  ProfileFeature
//
//  Created by 이지훈 on 7/1/25.
//

import SwiftUI

public struct ProfileCoordinatorView: View {
   @Environment(ProfileCoordinator.self) var coordinator
   
   public init() {
       print("👤 ProfileCoordinatorView 초기화")
   }
   
   public var body: some View {
       @Bindable var bindableCoordinator = coordinator
       
       NavigationStack(path: $bindableCoordinator.path) {
           coordinator.view(.main)
               .navigationDestination(for: ProfileRouter.Screen.self) { screen in
                   coordinator.view(screen)
               }
               .sheet(item: $bindableCoordinator.sheet) { sheet in
                   NavigationView {
                       coordinator.presentView(sheet)
                           .navigationBarTitleDisplayMode(.inline)
                           .toolbar {
                               ToolbarItem(placement: .navigationBarLeading) {
                                   Button("닫기") {
                                       coordinator.dismissSheet()
                                   }
                               }
                           }
                   }
               }
       }
       .environment(coordinator)
   }
}
