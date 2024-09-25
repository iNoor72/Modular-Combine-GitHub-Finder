//
//  UITableView.swift
//  GitHub-repos-browser
//
//  Created by Noor El-Din Walid on 16/09/2024.
//

import UIKit.UITableView

extension UITableView {
    func showNoResults() {
        let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        noDataLabel.text = AppStrings.noResultsString
        noDataLabel.textColor = UIColor.black
        noDataLabel.textAlignment = .center
        self.backgroundView  = noDataLabel
    }
}
