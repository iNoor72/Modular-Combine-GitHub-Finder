//
//  ForkingUsersViewFactory.swift
//  GitHub-repos-browser
//
//  Created by Noor El-Din Walid on 15/09/2024.
//

import UIKit

protocol ForkingUsersViewFactoryProtocol {
    func make(repositoryViewItem: RepositoryViewItem) -> UIViewController
}

final class ForkingUsersViewFactory: ForkingUsersViewFactoryProtocol {
    func make(repositoryViewItem: RepositoryViewItem) -> UIViewController {
        let router = ForkingUsersRouter()
        let repository = RepositoryItemsRepository()
        let viewModel = ForkingUsersViewModel(repository: repositoryViewItem, fetchForkingUsersRepositoriesUseCase: FetchForkingUsersRepositoriesUseCaseImpl(reposRepository: repository), router: router)
        let forkingUsersViewController = ForkedUsersViewController(viewModel: viewModel)
        
        router.viewController = forkingUsersViewController
        
        forkingUsersViewController.navigationItem.title = "Forked Users"
        
        return forkingUsersViewController
    }
}
