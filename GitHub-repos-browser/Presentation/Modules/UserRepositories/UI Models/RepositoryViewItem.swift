//
//  RepositoryViewItem.swift
//  GitHub-repos-browser
//
//  Created by Noor El-Din Walid on 14/09/2024.
//

import Foundation

struct RepositoryViewItem {
    init(repository: Repository) {
        cloudId = repository.cloudId
        name = repository.name
        owner = UserViewItem(user: repository.owner)
        description = repository.description ?? "No description"
        forksCount = repository.forksCount ?? 0
        createdAt = repository.createdAt ?? "No creation date"
        license = repository.license ?? License(key: nil, name: nil, url: nil)
        repoURL = repository.repoURL
    }
    
    let id = UUID()
    let cloudId: Int
    let name: String
    let owner: UserViewItem?
    let description: String?
    let forksCount: Int?
    let createdAt: String?
    let license: License?
    let repoURL: String
}
