//
//  Repository Protocols
//  Domain/RepositoryInterface
//
//  Tuist 모듈화 환경 - Domain 모듈
//

import Foundation
import Domain

public final class LoginUseCase: LoginUseCaseProtocol {
    private let authRepository: AuthRepositoryProtocol
    
    public init(authRepository: AuthRepositoryProtocol) {
        self.authRepository = authRepository
        print("🔑 LoginUseCase 생성")
    }
    
    public func execute(email: String, password: String) async -> Result<Bool, Error> {
        print("🔐 로그인 시도: \(email)")
        return await authRepository.login(email: email, password: password)
    }
}
