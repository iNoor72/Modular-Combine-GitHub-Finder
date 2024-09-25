//
//  UsersListRouter.swift
//  GitHub-repos-browser
//
//  Created by Noor El-Din Walid on 15/09/2024.
//

import UIKit

final class OrderManager {
    static let shared = Ordering()
//    static var orderItem: UserViewItem()
}

protocol UsersListRouterProtocol {
    func navigateToRepos(for user: UserViewItem)
}

final class UsersListRouter: UsersListRouterProtocol {
    weak var viewController: UIViewController?
    
    func navigateToRepos(for user: UserViewItem) {
        let router = UserRepositoriesRouter()
        let viewModel = UserRepositoriesViewModel(user: user, router: router)
        let repositoriesViewController = UserRepositoriesViewController(viewModel: viewModel)
        
        router.viewController = repositoriesViewController
        
        repositoriesViewController.navigationItem.title = "Repositories"
        repositoriesViewController.navigationItem.largeTitleDisplayMode = .always
        
        viewController?.navigationController?.pushViewController(repositoriesViewController, animated: true)
    }
}
