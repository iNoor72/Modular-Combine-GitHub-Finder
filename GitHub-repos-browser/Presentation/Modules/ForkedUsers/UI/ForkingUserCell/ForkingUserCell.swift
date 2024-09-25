//
//  ForkingUserCell.swift
//  GitHub-repos-browser
//
//  Created by Noor El-Din Walid on 14/09/2024.
//

import SwiftUI

struct ForkingUserCell: View {
    var user: UserViewItem
    
    var body: some View {
        VStack {
            HStack {
                CacheAsyncImage(url: URL(string: user.avatarURL)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(8.0)
                            .frame(width: 100, height: 100)
                    default:
                        Image(systemName: "person.fill")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(8.0)
                    }
                }
                
                Text(user.username)
                    .font(.headline)
                    .bold()
                    .padding()
            }
        }
    }
}

#Preview {
    ForkingUserCell(user: UserViewItem(username: "Noor", avatarURL: "https://avatars.githubusercontent.com/u/1?v=4", followersCount: 0, repositoriesCount: 0))
}
