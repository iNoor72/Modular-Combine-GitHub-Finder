//
//  ForkedUsersViewController.swift
//  GitHub-repos-browser
//
//  Created by Noor El-Din Walid on 14/09/2024.
//

import UIKit
import SwiftUI
import Combine

class ForkedUsersViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    private let cellReusableID = "cell"
    private let viewModel: ForkingUsersViewModel?
    private var cancellables = Set<AnyCancellable>()
    
    private enum Constants {
        static let cellHeight: CGFloat = 100
    }
    
    init(viewModel: ForkingUsersViewModel? = nil) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = nil
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel?.viewDidLoad()
    }
    
    private func setupUI() {
        setupTableView()
        setupUIBinding()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReusableID)
    }
    
    private func setupUIBinding() {
        guard let viewModel else {
            viewModel?.showError()
            return
        }
        
        viewModel.$state.sink { [weak self] state in
            guard let self else { return }
            
            switch state {
            case .loading:
                self.showLoadingIndicator()
            case .loaded:
                self.hideLoadingIndicator()
                self.tableView.reloadData()
                viewModel.$isEmptyResults.sink(receiveValue: { isEmpty in
                    self.tableView.showNoResults()
                }).store(in: &self.cancellables)
            case .error(let errorMessage):
                viewModel.showError(message: errorMessage)
            case .initial:
                break
            }
        }
        .store(in: &cancellables)
    }

}

extension ForkedUsersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = viewModel?.forkingUsers.count, count > 0 else {
            return 0
        }
        
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: cellReusableID,
            for: indexPath
        )
        
        guard let user = viewModel?.user(at: indexPath.row) else { return cell }
        cell.contentConfiguration = UIHostingConfiguration {
            ForkingUserCell(user: user)
        }
        
        if indexPath.row == 0 {
            
        } else if indd == 1
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants.cellHeight
    }
}
