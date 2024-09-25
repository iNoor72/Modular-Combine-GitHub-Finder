//
//  UserViewItem.swift
//  GitHub-repos-browser
//
//  Created by Noor El-Din Walid on 13/09/2024.
//

import Foundation

struct UserViewItem: Hashable {
    init(user: User) {
        self.username = user.login
        self.avatarURL = user.avatarUrl
        self.followersCount = followers.count
        self.repositoriesCount = repositories.count
    }
    
    init(username: String, avatarURL: String, followersCount: Int, repositoriesCount: Int, followers: [User] = [], repositories: [Repository] = []) {
        self.init(user: User(cloudId: 0, login: username, avatarUrl: avatarURL))
        self.followersCount = followersCount
        self.repositoriesCount = repositoriesCount
        self.followers = followers
        self.repositories = repositories
    }
    
    let id = UUID()
    var username: String
    var avatarURL: String
    var followersCount: Int
    var repositoriesCount: Int
    var followers: [User] = []
    var repositories: [Repository] = []
}
