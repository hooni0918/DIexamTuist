//
//  AuthRepository.swift
//  Domain
//
//  Created by 이지훈 on 6/30/25.
//

import Foundation

public protocol AuthRepositoryProtocol {
    func login(email: String, password: String) async -> Result<Bool, Error>
    func logout()
    func isLoggedIn() -> Bool
}
