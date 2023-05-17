//
//  Bundle+Ext.swift
//  CryptoVault-UIKit
//
//  Created by Cuma on 17/05/2023.
//

import Foundation

extension Bundle {
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
}
