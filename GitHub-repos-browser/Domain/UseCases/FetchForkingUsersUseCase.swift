//
//  FetchForkingUsersUseCase.swift
//  GitHub-repos-browser
//
//  Created by Noor El-Din Walid on 13/09/2024.
//

import Foundation
import Combine
import Data

protocol FetchForkingUsersRepositoriesUseCase {
    func execute(by username: String, for repoName: String) -> AnyPublisher<[Repository]?, NetworkError>
}

final class FetchForkingUsersRepositoriesUseCaseImpl: FetchForkingUsersRepositoriesUseCase {
    private let reposRepository: RepositoryItemsRepositoryProtocol
    
    init(reposRepository: RepositoryItemsRepositoryProtocol) {
        self.reposRepository = reposRepository
    }
    
    func execute(by username: String, for repoName: String) -> AnyPublisher<[Repository]?, NetworkError> {
        reposRepository.fetchForksRepositories(by: username, for: repoName)
    }
}

final class FetchForkingUsersRepositoriesUseCaseMock: FetchForkingUsersRepositoriesUseCase {
    func execute(by username: String, for repoName: String) -> AnyPublisher<[Repository]?, NetworkError> {
        Future<[Repository]?, NetworkError> { promise in
            promise(.success([Repository(cloudId: 0, name: "Repo", owner: User(cloudId: 0, login: "User", avatarUrl: "URL"), description: "Description", forksCount: 0, createdAt: "Date", license: nil, repoURL: "URL")]))
        }.eraseToAnyPublisher()
    }
}
