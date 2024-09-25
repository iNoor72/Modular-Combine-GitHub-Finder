//
//  UsersListViewFactoryTests.swift
//  GitHub-repos-browserTests
//
//  Created by Noor El-Din Walid on 16/09/2024.
//

import XCTest
import SwiftUI
@testable import GitHub_repos_browser

final class UsersListViewFactoryTests: XCTestCase {
    var sut: UserListViewFactoryProtocol!
    
    override func setUp() {
        super.setUp()
        sut = UserListViewFactory()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_make() {
        let viewController = sut.make()
        
        XCTAssertNotNil(viewController)
        XCTAssertTrue(viewController is UINavigationController)
        XCTAssert(viewController.children.first is UIHostingController<UsersListView>)
    }
}
