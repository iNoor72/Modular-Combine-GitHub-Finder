//
//  UserRepositoriesViewController.swift
//  GitHub-repos-browser
//
//  Created by Noor El-Din Walid on 14/09/2024.
//

import UIKit
import SwiftUI

class UserRepositoriesViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var followersCountLabel: UILabel!
    @IBOutlet private weak var reposCountLabel: UILabel!
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var userImageView: UIImageView!
    
    private let viewModel: UserRepositoriesViewModel?
    
    private enum Constants {
        static let cellHeight: CGFloat = 211
    }
    
    init(viewModel: UserRepositoriesViewModel? = nil) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = nil
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel?.getScreenTitle()
        setupUI()
    }
    
    private func setupUI() {
        setupTableView()
        userImageView.layer.cornerRadius = userImageView.frame.size.width / 2
        userImageView.layer.masksToBounds = true
        followersCountLabel.text = viewModel?.getFollowersCount().toString()
        reposCountLabel.text = viewModel?.getReposCount().toString()
        usernameLabel.text = viewModel?.getScreenTitle()
        userImageView.image = ImageCache[URL(string: viewModel?.getUserAvatarUrl() ?? "") ?? URL(string: "")!]?.asUIImage()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: String(describing: RepositoryTableViewCell.self), bundle: nil), forCellReuseIdentifier: AppConstants.TableViewCells.repositoryTableViewCell)
    }
}

extension UserRepositoriesViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        AppStrings.repositoriesSectionTitle
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = viewModel?.getReposCount(), count > 0 else {
            tableView.showNoResults()
            return 0
        }
        
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: AppConstants.TableViewCells.repositoryTableViewCell) as? RepositoryTableViewCell,
            let repository = viewModel?.getRepository(at: indexPath.row)
        else {
            return UITableViewCell()
        }
        
        cell.accessoryType = .disclosureIndicator
        cell.configure(with: repository)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.navigateToForkingUsers(for: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants.cellHeight
    }
}

struct UIKitViewControllerWrapper: UIViewControllerRepresentable {
    private let user: UserViewItem
    
    init(user: UserViewItem) {
        self.user = user
    }
    
    func makeUIViewController(context: Context) -> UserRepositoriesViewController {
        let factory = UserRepositoriesViewFactory()
        let viewController = factory.make(user: user)
        
        return viewController as! UserRepositoriesViewController
    }
    
    func updateUIViewController(_ uiViewController: UserRepositoriesViewController, context: Context) {
        // Update the view controller if needed
    }
}
