//
//  RepositoryItemsRepository.swift
//  GitHub-repos-browser
//
//  Created by Noor El-Din Walid on 12/09/2024.
//

import Foundation
import Combine
import Data

protocol RepositoryItemsRepositoryProtocol {
    func fetchRepositories(for username: String) -> AnyPublisher<[Repository]?, NetworkError>
    func fetchForksRepositories(by username: String, for repoName: String) -> AnyPublisher<[Repository]?, NetworkError>
}

final class RepositoryItemsRepository: RepositoryItemsRepositoryProtocol {
    private let networkManager: NetworkServiceProtocol
    
    private var bag = Set<AnyCancellable>()
    
    init(networkManager: NetworkServiceProtocol = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    func fetchRepositories(for username: String) -> AnyPublisher<[Repository]?, NetworkError> {
        let endpoint = RepositoryEndpoints.fetchUserRepositories(username: username)
        do {
            return try networkManager
                .fetch(endpoint: endpoint, expectedType: [RepositoryResponse].self)
                .map { //
                    $0.map { Repository(repository: $0) } }
                .eraseToAnyPublisher()
        } catch {
            return Future<[Repository]?, NetworkError> { promise in
                promise(.failure(NetworkError.decodingError))
            }.eraseToAnyPublisher()
        }
    }
    
    func fetchForksRepositories(by username: String, for repoName: String) -> AnyPublisher<[Repository]?, NetworkError> {
        let endpoint = RepositoryEndpoints.fetchForks(username: username, repoName: repoName)
        do {
            return try networkManager
                .fetch(endpoint: endpoint, expectedType: [RepositoryResponse].self)
                .map { $0.map { Repository(repository: $0) } }
                .eraseToAnyPublisher()
        } catch {
            return Future<[Repository]?, NetworkError> { promise in
                promise(.failure(NetworkError.decodingError))
            }.eraseToAnyPublisher()
        }
    }
}

final class MockRepositoryItemsRepository: RepositoryItemsRepositoryProtocol {
    func fetchRepositories(for username: String) -> AnyPublisher<[Repository]?, NetworkError> {
        Future<[Repository]?, NetworkError> { promise in
            promise(.success([Repository]()))
        }.eraseToAnyPublisher()
    }
    
    func fetchForksRepositories(by username: String, for repoName: String) -> AnyPublisher<[Repository]?, NetworkError> {
        Future<[Repository]?, NetworkError> { promise in
            promise(.success([Repository]()))
        }.eraseToAnyPublisher()
    }
}
