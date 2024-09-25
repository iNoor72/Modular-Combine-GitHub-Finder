//
//  UsersListView.swift
//  GitHub-repos-browser
//
//  Created by Noor El-Din Walid on 12/09/2024.
//

import SwiftUI

struct UsersListView: View {
    @ObservedObject var viewModel: UsersListViewModel
    
    var body: some View {
        ZStack {
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .loaded:
                mainView
            case .error(let errorMessage):
                RetryView(errorMessage: errorMessage) {
                    viewModel.onAppear()
                }
            case .initial:
                EmptyView()
            }
        }
        .task {
            if !viewModel.isFirstLoaded {
                viewModel.onAppear()
            }
        }
    }
    
    private var mainView: some View {
        VStack {
            List($viewModel.users, id: \.id) { user in
                UserItemRow(
                    user: user,
                    action: {
                        viewModel.navigateToRepos(for: user.wrappedValue)
                    })
            }
        }
        .navigationTitle("Users")
    }
}

#Preview {
    UsersListView(
        viewModel: UsersListViewModel(
            fetchAllUsersUseCase: FetchAllUsersUseCaseMock(),
            fetchFollowersUseCase: FetchFollowersUseCaseMock(),
            fetchRepositoriesUseCase: FetchRepositoresUseCaseMock(),
            router: UsersListRouter()
            )
    )
}
