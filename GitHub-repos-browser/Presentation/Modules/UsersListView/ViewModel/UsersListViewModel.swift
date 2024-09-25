//
//  UsersListViewModel.swift
//  GitHub-repos-browser
//
//  Created by Noor El-Din Walid on 12/09/2024.
//

import Foundation
import Combine
import Data

enum UsersListViewModelState {
    case loading
    case loaded
    case error(errorMessage: String)
    case initial
}

final class UsersListViewModel: ObservableObject {
    @Published var state: UsersListViewModelState = .initial
    @Published var users: [UserViewItem] = []
    var isFirstLoaded = false
    
    private let fetchAllUsersUseCase: FetchAllUsersUseCase
    private let fetchFollowersUseCase: FetchFollowersUseCase
    private let fetchRepositoriesUseCase: FetchRepositoriesUseCase
    private let router: UsersListRouterProtocol
    
    private var cancellables = Set<AnyCancellable>()
    
    init(fetchAllUsersUseCase: FetchAllUsersUseCase,
         fetchFollowersUseCase: FetchFollowersUseCase,
         fetchRepositoriesUseCase: FetchRepositoriesUseCase,
         router: UsersListRouterProtocol) {
        self.fetchAllUsersUseCase = fetchAllUsersUseCase
        self.fetchFollowersUseCase = fetchFollowersUseCase
        self.fetchRepositoriesUseCase = fetchRepositoriesUseCase
        self.router = router
    }
    
    func onAppear() {
        fetchUsersData()
    }
    
    func navigateToRepos(for user: UserViewItem) {
        router.navigateToRepos(for: user)
    }
    
    private func fetchUsersData() {
        state = .loading
        fetchAllUsersUseCase.execute()
            .flatMap { users in
                self.fetchFollowersAndRepositories(for: users ?? [])
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.state = .error(errorMessage: error.description)
                }
            } receiveValue: { [weak self] users in
                self?.users = users
                self?.state = .loaded
                self?.isFirstLoaded = true
            }
            .store(in: &cancellables)
    }
    
    private func fetchFollowersAndRepositories(for users: [User]) -> AnyPublisher<[UserViewItem], NetworkError> {
           let userViewItems = users.map { user in
               self.executeUseCases(for: user)
           }
           
           return Publishers.MergeMany(userViewItems)
               .collect()
               .eraseToAnyPublisher()
       }
    
    private func executeUseCases(for user: User) -> AnyPublisher<UserViewItem, NetworkError> {
        let userFollowers = fetchFollowersUseCase.execute(for: user.login)
        let userRepos = fetchRepositoriesUseCase.execute(for: user.login)
        
        return Publishers.Zip(userFollowers, userRepos)
            .map { followers, repositories in
                return UserViewItem(
                    username: user.login,
                    avatarURL: user.avatarUrl,
                    followersCount: followers?.count ?? 0,
                    repositoriesCount: repositories?.count ?? 0,
                    followers: followers ?? [],
                    repositories: repositories ?? []
                )
            }
            .eraseToAnyPublisher()
    }
}
