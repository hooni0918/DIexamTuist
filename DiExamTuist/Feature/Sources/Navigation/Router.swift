//
//  Router.swift
//  Feature
//
//  Created by 이지훈 on 6/30/25.
//

import Foundation
import SwiftUI

// MARK: - Router Protocol (Domain Layer)
public protocol Router: AnyObject, ObservableObject {
    var currentRoute: Route { get set }
    func navigate(to route: Route)
    func goBack()
}
