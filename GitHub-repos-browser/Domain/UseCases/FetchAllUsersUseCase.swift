//
//  FetchAllUsersUseCase.swift
//  GitHub-repos-browser
//
//  Created by Noor El-Din Walid on 13/09/2024.
//

import Foundation
import Combine
import Data

protocol FetchAllUsersUseCase {
    func execute() -> AnyPublisher<[User]?, NetworkError>
}

final class FetchAllUsersUseCaseImpl: FetchAllUsersUseCase {
    private let usersRepository: UsersRepositoryProtocol
    
    init(usersRepository: UsersRepositoryProtocol) {
        self.usersRepository = usersRepository
    }
    
    func execute() -> AnyPublisher<[User]?, NetworkError> {
        usersRepository.fetchAllUsers()
    }
}

final class FetchAllUsersUseCaseMock: FetchAllUsersUseCase {
    func execute() -> AnyPublisher<[User]?, NetworkError> {
        Future<[User]?, NetworkError> { promise in
            promise(.success([User(cloudId: 1, login: "iNoor72", avatarUrl: "")]))
        }.eraseToAnyPublisher()
    }
}
