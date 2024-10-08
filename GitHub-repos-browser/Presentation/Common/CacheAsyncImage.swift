//
//  CacheAsyncImage.swift
//  GitHub-repos-browser
//
//  Created by Noor El-Din Walid on 13/09/2024.
//

import SwiftUI

struct CacheAsyncImage<Content>: View where Content: View {
    private let url: URL?
    private let scale: CGFloat
    private let transaction: Transaction
    private let content: (AsyncImagePhase) -> Content
    private let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    @State private var trialsCounter = 5

    init(
        url: URL?,
        scale: CGFloat = 1.0,
        transaction: Transaction = Transaction(),
        @ViewBuilder content: @escaping (AsyncImagePhase) -> Content
    ) {
        self.url = url
        self.scale = scale
        self.transaction = transaction
        self.content = content
    }

    var body: some View {

        if let url = url, let cached = ImageCache[url] {
            content(.success(cached))
        } else {
            AsyncImage(
                url: url,
                scale: scale,
                transaction: transaction
            ) { phase in
                if trialsCounter <= 0 {
                    Image(AppConstants.imagePlaceholderName)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(8.0)
                } else {
                    cacheAndRender(phase: phase)
                }
            }.onReceive(timer) { _ in
                if trialsCounter > 0 {
                    trialsCounter -= 1
                } else {
                    timer.upstream.connect().cancel()
                }
            }
        }
    }

    func cacheAndRender(phase: AsyncImagePhase) -> some View {
        if case .success(let image) = phase {
            guard let url else { return content(phase) }
            ImageCache[url] = image
        }

        return content(phase)
    }
}
