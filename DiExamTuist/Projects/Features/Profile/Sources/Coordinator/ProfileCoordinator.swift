//
//  ProfileCoordinator.swift
//  ProfileFeature
//
//  Created by 이지훈 on 7/1/25.
//

import SwiftUI
import Core

@Observable
public final class ProfileCoordinator: Coordinatorable {
   public typealias Screen = ProfileRouter.Screen
   public typealias SheetScreen = ProfileRouter.Sheet
   public typealias FullScreen = ProfileRouter.FullScreen
   
   public var path: NavigationPath = NavigationPath()
   public var sheet: SheetScreen?
   public var fullScreenCover: FullScreen?
   
   public init() {
       print("🧭 ProfileCoordinator 생성")
   }
   
   @ViewBuilder
   public func view(_ screen: Screen) -> some View {
       switch screen {
       case .main:
           ProfileView()
       case .editProfile:
           EditProfileView()
       }
   }
   
   @ViewBuilder
   public func presentView(_ sheet: SheetScreen) -> some View {
       switch sheet {
       case .logout:
           LogoutConfirmView()
       }
   }
   
   @ViewBuilder
   public func fullCoverView(_ cover: FullScreen) -> some View {
       EmptyView()
   }
}

public enum ProfileRouter {
   public enum Screen: Hashable {
       case main
       case editProfile
   }
   
   public enum Sheet: String, Identifiable {
       case logout
       public var id: String { self.rawValue }
   }
   
   public enum FullScreen: String, Identifiable {
       case none
       public var id: String { self.rawValue }
   }
}
