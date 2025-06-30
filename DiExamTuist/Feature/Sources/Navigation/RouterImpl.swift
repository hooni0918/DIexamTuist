//
//  RouterImpl.swift
//  Feature
//
//  Created by 이지훈 on 6/30/25.
//

import Foundation
import SwiftUI

// MARK: - Router Implementation (Presentation Layer)
public class RouterImpl: Router {
    @Published public var currentRoute: Route = .home
    private var navigationStack: [Route] = [.home]
    
    public init() {}
    
    public func navigate(to route: Route) {
        currentRoute = route
        navigationStack.append(route)
    }
    
    public func goBack() {
        if navigationStack.count > 1 {
            navigationStack.removeLast()
            currentRoute = navigationStack.last ?? .home
        }
    }
}
