//
//  AuthRepository.swift
//  Domain
//
//  Created by 이지훈 on 6/30/25.
//

import Foundation

// MARK: - Auth Repository Protocol
public protocol AuthRepository {
    func login(email: String, password: String) async -> Result<Bool, Error>
    func logout()
    func isLoggedIn() -> Bool
}
