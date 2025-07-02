import Foundation

public struct User {
   public let id: String
   public let name: String
   public let email: String
   
   public init(id: String, name: String, email: String) {
       self.id = id
       self.name = name
       self.email = email
   }
}

public protocol HomeRepository {
   func getCurrentUser() -> User?
   func updateUser(_ user: User)
   func getAllUsers() -> [User]
   func switchUser(to userId: String)
}

public protocol GetCurrentUserUseCaseProtocol {
   func execute() -> User?
}

public protocol GetAllUsersUseCaseProtocol {
   func execute() -> [User]
}

public protocol SwitchUserUseCaseProtocol {
   func execute(userId: String)
}
