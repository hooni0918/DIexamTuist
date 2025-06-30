//
//  NetworkManager.swift
//  Core
//
//  Created by 이지훈 on 6/30/25.
//

import Foundation

// MARK: - Network Manager (향후 확장용)
public class NetworkManager {
    public static let shared = NetworkManager()
    
    private init() {}
    
    public func request<T: Codable>(
        _ endpoint: String,
        method: HTTPMethod = .GET,
        parameters: [String: Any]? = nil
    ) async throws -> T {
        // 네트워크 요청 구현
        fatalError("Not implemented yet")
    }
}

public enum HTTPMethod: String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
}
