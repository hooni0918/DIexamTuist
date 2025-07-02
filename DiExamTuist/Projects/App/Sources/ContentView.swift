//
//  ContentView.swift
//  App
//
//  Created by 이지훈 on 7/1/25.
//

import SwiftUI

struct ContentView: View {
   
   @State private var routeState: ContentView.RouteType = .home
   private let coordinatorFactory: CoordinatorFactory = CoordinatorFactory()
   
   init() {
       print("📱 ContentView 초기화 (HGDGDS 전체 구조)")
   }
   
   var body: some View {
       VStack {
           HStack {
               Button("홈") { 
                   routeState = .home 
                   print("🏠 홈으로 이동")
               }
               .padding()
               .background(routeState == .home ? Color.blue : Color.gray)
               .foregroundColor(.white)
               .cornerRadius(8)
               
               Button("프로필") { 
                   routeState = .profile 
                   print("👤 프로필로 이동")
               }
               .padding()
               .background(routeState == .profile ? Color.green : Color.gray)
               .foregroundColor(.white)
               .cornerRadius(8)
               
               Button("로그인") { 
                   routeState = .login 
                   print("🔐 로그인으로 이동")
               }
               .padding()
               .background(routeState == .login ? Color.orange : Color.gray)
               .foregroundColor(.white)
               .cornerRadius(8)
           }
           .padding()
           
           contentView
       }
   }
   
   @ViewBuilder
   private var contentView: some View {
       switch routeState {
       case .home:
           coordinatorFactory.homeCoordinatorRootView
       case .profile:
           coordinatorFactory.profileCoordinatorRootView
       case .login:
           coordinatorFactory.loginCoordinatorRootView
       }
   }
}

extension ContentView {
   enum RouteType {
       case home
       case profile
       case login
   }
}

#Preview {
   ContentView()
}
