//
//  UserItemRow.swift
//  GitHub-repos-browser
//
//  Created by Noor El-Din Walid on 13/09/2024.
//

import SwiftUI

struct UserItemRow: View {
    @Binding var user: UserViewItem
    var action: (() -> ())?
    
    var body: some View {
            HStack {
                CacheAsyncImage(url: URL(string: user.avatarURL), content: { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                        
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(8.0)
                        
                        //Including error state
                    default:
                        Image(AppConstants.imagePlaceholderName)
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(8.0)
                    }
                })
                .frame(width: 100, height: 150)
                
                Spacer()
                
                VStack(alignment: .center) {
                    Text(user.username)
                        .font(.headline)
                    
                    Text("# of repos: \(user.repositoriesCount)")
                        .font(.subheadline)
                    
                    Text("# of followers: \(user.followersCount)")
                        .font(.subheadline)
                }
                
                Spacer()
                
                Button { action?() } label: {
                    Image(systemName: "chevron.right")
                        .resizable()
                        .frame(width: 10, height: 10)
                        .foregroundColor(.gray)
                }
            }
        .onTapGesture {
            action?()
        }
    }
}

//#Preview {
//    UserItemRow(user: .constant(UserViewItem(username: "", avatarURL: "", followersCount: 1, repositoriesCount: 1)), destinationView: EmptyView())
//}
