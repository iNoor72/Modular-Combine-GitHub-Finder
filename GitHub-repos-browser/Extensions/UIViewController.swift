//
//  UIViewController.swift
//  GitHub-repos-browser
//
//  Created by Noor El-Din Walid on 14/09/2024.
//

import UIKit.UIViewController

extension UIViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    func showLoadingIndicator() {
        let loadingIndicator = UIActivityIndicatorView(style: .large)
        loadingIndicator.startAnimating()
        loadingIndicator.center = view.center
        view.addSubview(loadingIndicator)
    }
    
    func hideLoadingIndicator() {
        view.subviews.first(where: { $0 is UIActivityIndicatorView })?.removeFromSuperview()
    }
}
