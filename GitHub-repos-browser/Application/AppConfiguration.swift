//
//  AppConfiguration.swift
//  GitHub-repos-browser
//
//  Created by Noor El-Din Walid on 12/09/2024.
//

import Foundation

enum AppConfiguration {
    static let baseURL = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String ?? ""
    static let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String ?? ""
}
