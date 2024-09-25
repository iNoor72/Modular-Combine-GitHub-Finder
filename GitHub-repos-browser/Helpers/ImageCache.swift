//
//  ImageCache.swift
//  GitHub-repos-browser
//
//  Created by Noor El-Din Walid on 14/09/2024.
//

import SwiftUI

final class ImageCache {
    static private var cache: [URL: Image] = [:]

    static subscript(url: URL) -> Image? {
        get {
            ImageCache.cache[url]
        }
        set {
            //Cache 20 images at max, for the app not to grow quickly on memory
            if cache.count > 20 {
                _ = cache.popFirst()
            }
            ImageCache.cache[url] = newValue
        }
    }
}
