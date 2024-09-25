//
//  ForkingUsersViewFactoryTests.swift
//  GitHub-repos-browserTests
//
//  Created by Noor El-Din Walid on 16/09/2024.
//

import XCTest
@testable import GitHub_repos_browser

final class ForkingUsersViewFactoryTests: XCTestCase {
    var sut: ForkingUsersViewFactoryProtocol!
    
    override func setUp() {
        super.setUp()
        sut = ForkingUsersViewFactory()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_make() {
        let repo = Repository(cloudId: 1, name: "Test", owner: User(cloudId: 1, login: "iNoor72", avatarUrl: ""), description: nil, forksCount: 1, createdAt: "", license: nil, repoURL: "")
        let viewItem = RepositoryViewItem(repository: repo)
        let viewController = sut.make(repositoryViewItem: viewItem)
        
        XCTAssertNotNil(viewController)
        XCTAssertTrue(viewController is ForkedUsersViewController)
    }
}
