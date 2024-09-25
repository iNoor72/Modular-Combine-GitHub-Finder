//
//  FetchRepositoriesUseCase.swift
//  GitHub-repos-browser
//
//  Created by Noor El-Din Walid on 13/09/2024.
//

import Foundation
import Combine
import Data

protocol FetchRepositoriesUseCase {
    func execute(for username: String) -> AnyPublisher<[Repository]?, NetworkError>
}

final class FetchRepositoriesUseCaseImpl: FetchRepositoriesUseCase {
    private let repositoriesRepository: RepositoryItemsRepositoryProtocol
    
    init(repositoriesRepository: RepositoryItemsRepositoryProtocol) {
        self.repositoriesRepository = repositoriesRepository
    }
    
    func execute(for username: String) -> AnyPublisher<[Repository]?, NetworkError> {
        repositoriesRepository.fetchRepositories(for: username)
    }
}

final class FetchRepositoresUseCaseMock: FetchRepositoriesUseCase {
    func execute(for username: String) -> AnyPublisher<[Repository]?, NetworkError> {
        Future<[Repository]?, NetworkError> { promise in
            promise(.success([Repository(cloudId: 1, name: "Test", owner: User(cloudId: 1, login: "iNoor72", avatarUrl: ""), description: nil, forksCount: 1, createdAt: "", license: nil, repoURL: "")]))
        }.eraseToAnyPublisher()
    }
}
