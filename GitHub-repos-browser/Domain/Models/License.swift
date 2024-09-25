//
//  License.swift
//  GitHub-repos-browser
//
//  Created by Noor El-Din Walid on 16/09/2024.
//

import Foundation
import Data

struct License: Hashable {
    let key, name: String?
    let url: String?
    
    init(key: String?, name: String?, url: String?) {
        self.key = key
        self.name = name
        self.url = url
    }
    
    init(licenseResponse: LicenseResponse?) {
        self.key = licenseResponse?.key
        self.name = licenseResponse?.name
        self.url = licenseResponse?.url
    }
}
