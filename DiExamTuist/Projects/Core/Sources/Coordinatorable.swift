//
//  Coordinatorable.swift
//  Core
//
//  Created by 이지훈 on 7/1/25.
//

import SwiftUI

@MainActor
public protocol Coordinatorable: AnyObject {
    associatedtype Screen: Hashable
    associatedtype SheetScreen: RawRepresentable, Identifiable
    associatedtype FullScreen: RawRepresentable, Identifiable
    
    associatedtype PushView: View
    associatedtype SheetView: View
    associatedtype FullView: View
    
    var path: NavigationPath { get set }
    var sheet: SheetScreen? { get set }
    var fullScreenCover: FullScreen? { get set }
    
    @ViewBuilder
    func view(_ screen: Screen) -> PushView
    @ViewBuilder
    func presentView(_ sheet: SheetScreen) -> SheetView
    @ViewBuilder
    func fullCoverView(_ cover: FullScreen) -> FullView
}

public extension Coordinatorable {
    func push(_ page: Screen...) {
        page.forEach {
            path.append($0)
            print("🔄 화면 이동: \($0)")
        }
    }
    
    func sheet(_ sheet: SheetScreen) {
        self.sheet = sheet
        print("📋 시트 표시: \(sheet)")
    }
    
    func fullCover(_ cover: FullScreen) {
        self.fullScreenCover = cover
        print("🖼️ 풀스크린 표시: \(cover)")
    }
    
    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
        print("⬅️ 뒤로가기")
    }
    
    func popToRoot() {
        guard !path.isEmpty else { return }
        let count = path.count
        path.removeLast(count)
        print("🏠 루트로 이동 (\(count)개 화면 제거)")
    }
    
    func dismissSheet() {
        self.sheet = nil
        print("❌ 시트 닫기")
    }
    
    func dismissCover() {
        self.fullScreenCover = nil
        print("❌ 풀스크린 닫기")
    }
}
