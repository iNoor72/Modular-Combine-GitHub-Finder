//
//  UserRepositoriesViewFactory.swift
//  GitHub-repos-browser
//
//  Created by Noor El-Din Walid on 15/09/2024.
//

import UIKit

protocol

struct UserRepositoriesViewFactoryDependencies {
    let user: UserViewItem
    //Another dependencies here
}

protocol UserRepositoriesViewFactoryProtocol {
    func make(user: UserViewItem) -> UIViewController
}

final class UserRepositoriesViewFactory: UserRepositoriesViewFactoryProtocol {
    func make(user: UserViewItem) -> UIViewController {
        let router = UserRepositoriesRouter()
        let viewModel = UserRepositoriesViewModel(user: user, router: router)
        let viewController = UserRepositoriesViewController(viewModel: viewModel)
        router.viewController = viewController
        
        return viewController
    }
}
