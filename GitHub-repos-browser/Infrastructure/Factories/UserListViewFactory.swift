//
//  UserListViewFactory.swift
//  GitHub-repos-browser
//
//  Created by Noor El-Din Walid on 15/09/2024.
//

import SwiftUI

protocol UserListViewFactoryProtocol {
    func make() -> UIViewController
}

final class UserListViewFactory: UserListViewFactoryProtocol {
    func make() -> UIViewController {
        let usersRepository = UsersRepository()
        let repositoriesRepository = RepositoryItemsRepository()
        
        let fetchAllUsersUseCase = FetchAllUsersUseCaseImpl(usersRepository: usersRepository)
        let fetchFollowersUseCase = FetchFollowersUseCaseImpl(usersRepository: usersRepository)
        let fetchRepositoriesUseCase = FetchRepositoriesUseCaseImpl(repositoriesRepository: repositoriesRepository)
        
        let router = UsersListRouter()
        
        let usersViewModel = UsersListViewModel(
            fetchAllUsersUseCase: fetchAllUsersUseCase,
            fetchFollowersUseCase: fetchFollowersUseCase,
            fetchRepositoriesUseCase: fetchRepositoriesUseCase,
            router: router
        )
        
        let usersListView = UsersListView(viewModel: usersViewModel)
        let hostingViewController = UIHostingController(rootView: usersListView)
        let navigationController = UINavigationController(rootViewController: hostingViewController)
        
        hostingViewController.navigationItem.title = "Users"
        
        router.viewController = hostingViewController
        
        return navigationController
    }
}
