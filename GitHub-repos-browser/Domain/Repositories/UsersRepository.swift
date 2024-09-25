//
//  UsersRepository.swift
//  GitHub-repos-browser
//
//  Created by Noor El-Din Walid on 12/09/2024.
//

import Foundation
import Combine
import Data

protocol UsersRepositoryProtocol {
    func fetchAllUsers() -> AnyPublisher<[User]?, NetworkError>
    func fetchFollowers(for username: String) -> AnyPublisher<[User]?, NetworkError>
}

final class UsersRepository: UsersRepositoryProtocol {
    private let networkManager: NetworkServiceProtocol
    
    private var bag = Set<AnyCancellable>()
    
    init(networkManager: NetworkServiceProtocol = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    func fetchAllUsers() -> AnyPublisher<[User]?, NetworkError> {
        let endpoint = UserEndpoint.fetchAllUsers
        do {
            return try networkManager
                .fetch(endpoint: endpoint, expectedType: [UserResponse].self)
                .map { $0.map { User(user: $0) } }
                .eraseToAnyPublisher()
        } catch {
            return Future<[User]?, NetworkError> { promise in
                promise(.failure(NetworkError.decodingError))
            }.eraseToAnyPublisher()
        }
    }
    
    func fetchFollowers(for username: String) -> AnyPublisher<[User]?, NetworkError> {
        let endpoint = UserEndpoint.fetchFollowers(username: username)
        do {
            return try networkManager
                .fetch(endpoint: endpoint, expectedType: [UserResponse].self)
                .map { $0.map { User(user: $0) } }
                .eraseToAnyPublisher()
        } catch {
            return Future<[User]?, NetworkError> { promise in
                promise(.failure(NetworkError.decodingError))
            }.eraseToAnyPublisher()
        }
    }
}

final class MockUsersRepository: UsersRepositoryProtocol {
    func fetchAllUsers() -> AnyPublisher<[User]?, NetworkError> {
        Future<[User]?, NetworkError> { promise in
            promise(.success([User]()))
        }.eraseToAnyPublisher()
    }
    
    func fetchFollowers(for username: String) -> AnyPublisher<[User]?, NetworkError> {
        Future<[User]?, NetworkError> { promise in
            promise(.success([User]()))
        }.eraseToAnyPublisher()
    }
}
