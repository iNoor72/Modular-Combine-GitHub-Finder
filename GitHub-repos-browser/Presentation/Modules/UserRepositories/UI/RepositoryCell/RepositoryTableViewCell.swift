//
//  RepositoryTableViewCell.swift
//  GitHub-repos-browser
//
//  Created by Noor El-Din Walid on 14/09/2024.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {
    @IBOutlet private weak var repoNameLabel: UILabel!
    @IBOutlet private weak var licenseLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    private var repoURL = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with repo: RepositoryViewItem) {
        repoNameLabel.text = repo.name
        licenseLabel.text = repo.license?.name ?? "No license"
        descriptionLabel.text = repo.description
        self.repoURL = repo.repoURL
    }
    @IBAction func openButtonTapped(_ sender: UIButton) {
        guard
            let url = URL(string: repoURL),
            UIApplication.shared.canOpenURL(url)
        else {
            return
        }
        
        UIApplication.shared.open(url)
    }
}
