//
//  UserRepositoriesRouter.swift
//  GitHub-repos-browser
//
//  Created by Noor El-Din Walid on 15/09/2024.
//

import UIKit

protocol UserRepositoriesRouterProtocol {
    func navigateToForkingUsers(for repositoryViewItem: RepositoryViewItem)
}

final class UserRepositoriesRouter: UserRepositoriesRouterProtocol {
    weak var viewController: UIViewController?
    
    func navigateToForkingUsers(for repositoryViewItem: RepositoryViewItem) {
        let factory = ForkingUsersViewFactory()
        let forkingUsersViewController = factory.make(repositoryViewItem: repositoryViewItem)
        
        viewController?.navigationController?.pushViewController(forkingUsersViewController, animated: true)
    }
}
