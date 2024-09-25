//
//  User.swift
//  GitHub-repos-browser
//
//  Created by Noor El-Din Walid on 12/09/2024.
//

import Foundation
import Data

struct User: Hashable {
    let id = UUID()
    let cloudId: Int
    let login: String
    let avatarUrl: String
    
    init(cloudId: Int, login: String, avatarUrl: String) {
        self.cloudId = cloudId
        self.login = login
        self.avatarUrl = avatarUrl
    }
    
    init(user: UserResponse) {
        self.cloudId = user.id
        self.login = user.login ?? ""
        self.avatarUrl = user.avatarURL ?? ""
    }
    
    func mapToViewItem() -> UserViewItem {
        UserViewItem(user: self)
    }
}
