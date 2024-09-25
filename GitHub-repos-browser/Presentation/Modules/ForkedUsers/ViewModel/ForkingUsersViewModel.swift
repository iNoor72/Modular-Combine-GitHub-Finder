//
//  ForkingUsersViewModel.swift
//  GitHub-repos-browser
//
//  Created by Noor El-Din Walid on 14/09/2024.
//

import Foundation
import Combine

enum ForkingUsersViewModelState: Equatable {
    case loading
    case loaded
    case error(errorMessage: String)
    case initial
}

final class ForkingUsersViewModel: ObservableObject {
    @Published var forkingUsers: [UserViewItem] = []
    @Published var state: ForkingUsersViewModelState = .initial
    @Published var isEmptyResults = false
    
    private let fetchForkingUsersRepositoriesUseCase: FetchForkingUsersRepositoriesUseCase
    private let repositoryViewItem: RepositoryViewItem
    private let router: ForkingUsersRouterProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(repository: RepositoryViewItem, fetchForkingUsersRepositoriesUseCase: FetchForkingUsersRepositoriesUseCase, router: ForkingUsersRouterProtocol) {
        self.repositoryViewItem = repository
        self.fetchForkingUsersRepositoriesUseCase = fetchForkingUsersRepositoriesUseCase
        self.router = router
    }
    
    func viewDidLoad() {
        fetchForkingUsers(for: repositoryViewItem)
    }
    
    
    
    func showError(message: String = AppStrings.unknownErrorString) {
        router.showError(message: message)
    }
    
    func user(at index: Int) -> UserViewItem? {
        forkingUsers[safe: index]
    }
    
    private func fetchForkingUsers(for repository: RepositoryViewItem) {
        state = .loading
        fetchForkingUsersRepositoriesUseCase.execute(by: repository.owner?.username ?? "", for: repository.name)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                if case let .failure(error) = completion {
                    self?.state = .error(errorMessage: error.description)
                }
            } receiveValue: { [weak self] forkingUsers in
                guard let self = self else { return }
                guard let forkingUsers = forkingUsers, !forkingUsers.isEmpty else {
                    self.isEmptyResults = true
                    self.state = .loaded
                    return
                }
                
                self.forkingUsers = forkingUsers.map { UserViewItem(user: $0.owner) }
                self.state = .loaded
            }
            .store(in: &cancellables)
    }
}
