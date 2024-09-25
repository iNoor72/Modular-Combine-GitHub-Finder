//
//  UsersListViewModelTests.swift
//  GitHub-repos-browserTests
//
//  Created by Noor El-Din Walid on 16/09/2024.
//

import XCTest
@testable import GitHub_repos_browser

final class MockUsersListRouter: UsersListRouterProtocol {
    var isNavigateToReposCalled = false
    func navigateToRepos(for user: UserViewItem) {
        isNavigateToReposCalled = true
    }
}

final class UsersListViewModelTests: XCTestCase {
    var sut: UsersListViewModel!
    var router: UsersListRouterProtocol!
    
    override func setUp() {
        super.setUp()
        router = MockUsersListRouter()
        sut = UsersListViewModel(fetchAllUsersUseCase: FetchAllUsersUseCaseMock(),
                                 fetchFollowersUseCase: FetchFollowersUseCaseMock(),
                                 fetchRepositoriesUseCase: FetchRepositoresUseCaseMock(),
                                 router: router)
    }
    
    override func tearDown() {
        router = nil
        sut = nil
        super.tearDown()
    }
    
    func test_navigate_to_repos() {
        sut.navigateToRepos(for: UserViewItem(username: "", avatarURL: "", followersCount: 0, repositoriesCount: 0))
        
        let router = router as! MockUsersListRouter
        XCTAssertTrue(router.isNavigateToReposCalled)
    }
    
}
