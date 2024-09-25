//
//  RepositoryItemsRepositoryTests.swift
//  GitHub-repos-browserTests
//
//  Created by Noor El-Din Walid on 16/09/2024.
//

import XCTest
import Data
import Combine
@testable import GitHub_repos_browser

final class RepositoryItemsRepositoryTests: XCTestCase {
    var sut: RepositoryItemsRepository!
    var networkService: NetworkServiceProtocol!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        networkService = MockNetworkManager.shared
        sut = RepositoryItemsRepository(networkManager: networkService)
        cancellables = Set<AnyCancellable>()
    }
    
    override func tearDown() {
        cancellables = nil
        sut = nil
        networkService = nil
        super.tearDown()
    }
    
    func test_fetch_user_repos() {
        let expectation = XCTestExpectation(description: "Fetch all users")
        
        sut.fetchRepositories(for: "Test")
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    //Should go here
                    XCTAssertEqual(error, NetworkError.invalidResponse)
                    expectation.fulfill()
                }
            } receiveValue: { users in
                XCTFail()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1)
    }
    
    func test_fetch_forking_repos() {
        let expectation = XCTestExpectation(description: "Fetch all users")
        
        sut.fetchForksRepositories(by: "Test-user", for: "repo")
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    //Should go here
                    XCTAssertEqual(error, NetworkError.invalidResponse)
                    expectation.fulfill()
                }
            } receiveValue: { users in
                XCTFail()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1)
    }
}
