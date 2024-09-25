//
//  UserRepositoriesViewFactoryTests.swift
//  GitHub-repos-browserTests
//
//  Created by Noor El-Din Walid on 16/09/2024.
//

import XCTest
@testable import GitHub_repos_browser

final class UserRepositoriesViewFactoryTests: XCTestCase {
    var sut: UserRepositoriesViewFactoryProtocol!
    
    override func setUp() {
        super.setUp()
        sut = UserRepositoriesViewFactory()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_make() {
        let user = User(cloudId: 1, login: "iNoor72", avatarUrl: "")
        let viewItem = UserViewItem(user: user)
        let viewController = sut.make(user: viewItem)
        
        XCTAssertNotNil(viewController)
        XCTAssertTrue(viewController is UserRepositoriesViewController)
    }
}
