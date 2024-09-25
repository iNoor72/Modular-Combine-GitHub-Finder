//
//  FetchFollowersUseCase.swift
//  GitHub-repos-browser
//
//  Created by Noor El-Din Walid on 13/09/2024.
//

import Foundation
import Combine
import Data

protocol FetchFollowersUseCase {
    func execute(for username: String) -> AnyPublisher<[User]?, NetworkError>
}

final class FetchFollowersUseCaseImpl: FetchFollowersUseCase {
    private let usersRepository: UsersRepositoryProtocol
    
    init(usersRepository: UsersRepositoryProtocol) {
        self.usersRepository = usersRepository
    }
    
    func execute(for username: String) -> AnyPublisher<[User]?, NetworkError> {
        usersRepository.fetchFollowers(for: username)
    }
}

final class FetchFollowersUseCaseMock: FetchFollowersUseCase {
    func execute(for username: String) -> AnyPublisher<[User]?, NetworkError> {
        Future<[User]?, NetworkError> { promise in
            promise(.success([User(cloudId: 1, login: "iNoor72", avatarUrl: "")]))
        }.eraseToAnyPublisher()
    }
}
