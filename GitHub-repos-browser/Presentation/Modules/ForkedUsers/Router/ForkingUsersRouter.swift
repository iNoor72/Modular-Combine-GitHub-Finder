//
//  ForkingUsersRouter.swift
//  GitHub-repos-browser
//
//  Created by Noor El-Din Walid on 15/09/2024.
//

import UIKit

protocol ForkingUsersRouterProtocol {
    func showError(message: String)
}

final class ForkingUsersRouter: ForkingUsersRouterProtocol {
    weak var viewController: UIViewController?
    
    func showError(message: String = AppStrings.unknownErrorString) {
        viewController?.showAlert(title: AppStrings.errorString, message: message)
    }
}
