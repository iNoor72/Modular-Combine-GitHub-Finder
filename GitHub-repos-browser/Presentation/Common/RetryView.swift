//
//  RetryView.swift
//  GitHub-repos-browser
//
//  Created by Noor El-Din Walid on 13/09/2024.
//

import SwiftUI

struct RetryView: View {
    var errorMessage: String?
    var retryAction: (() -> ())?
    
    var body: some View {
        VStack {
            Image(systemName: "exclamationmark.triangle")
                .resizable()
                .frame(width: 150, height: 150)
                .foregroundStyle(.red)
            
            Text(AppStrings.errorString)
                .padding()
                .font(.headline)
                .bold()
            
            Text(errorMessage ?? AppStrings.unknownErrorString)
                .padding()
                .font(.subheadline)
            
            Button("Try Again") {
                retryAction?()
            }
            .padding(.horizontal, 32)
            .padding(.vertical, 8)
            .background(.blue)
            .foregroundStyle(.white)
            .bold()
            .cornerRadius(8)
        }
    }
}

#Preview {
    RetryView()
}
