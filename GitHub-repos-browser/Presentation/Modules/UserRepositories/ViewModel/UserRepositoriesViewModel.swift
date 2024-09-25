//
//  UserRepositoriesViewModel.swift
//  GitHub-repos-browser
//
//  Created by Noor El-Din Walid on 14/09/2024.
//

import Foundation

final class UserRepositoriesViewModel {
    private let user: UserViewItem
    private let router: UserRepositoriesRouterProtocol
    
    init(user: UserViewItem, router: UserRepositoriesRouterProtocol) {
        self.user = user
        self.router = router
    }
    
    func getScreenTitle() -> String {
        user.username
    }
    
    func getReposCount() -> Int {
        user.repositoriesCount
    }
    
    func getFollowersCount() -> Int {
        user.followersCount
    }
    
    func getRepository(at index: Int) -> RepositoryViewItem {
        RepositoryViewItem(repository: user.repositories[index])
    }
    
    func getUserAvatarUrl() -> String {
        user.avatarURL
    }
    
    func navigateToForkingUsers(for index: Int) {
        let repositoryViewItem = user.repositories[index].mapToViewItem()
        router.navigateToForkingUsers(for: repositoryViewItem)
    }
}
