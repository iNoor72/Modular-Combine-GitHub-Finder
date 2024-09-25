//
//  Collection.swift
//  GitHub-repos-browser
//
//  Created by Noor El-Din Walid on 12/09/2024.
//

import Foundation

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
