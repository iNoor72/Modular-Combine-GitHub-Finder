//
//  Repository.swift
//  GitHub-repos-browser
//
//  Created by Noor El-Din Walid on 12/09/2024.
//

import Foundation
import Data

struct Repository: Hashable {
    let id = UUID()
    let cloudId: Int
    let name: String
    let owner: User
    let description: String?
    let forksCount: Int?
    let createdAt: String?
    let license: License?
    let repoURL: String
    
    init(cloudId: Int, name: String, owner: User, description: String?, forksCount: Int?, createdAt: String?, license: License?, repoURL: String) {
        self.cloudId = cloudId
        self.name = name
        self.owner = owner
        self.description = description
        self.forksCount = forksCount
        self.createdAt = createdAt
        self.license = license
        self.repoURL = repoURL
    }
    
    init(repository: RepositoryResponse) {
        self.cloudId = repository.id
        self.name = repository.name ?? ""
        self.owner = User(user: repository.owner)
        self.description = repository.description
        self.forksCount = repository.forksCount
        self.createdAt = repository.createdAt
        self.license = License(licenseResponse: repository.license)
        self.repoURL = repository.htmlURL ?? ""
    }
    
    func mapToViewItem() -> RepositoryViewItem {
        RepositoryViewItem(repository: self)
    }
}
