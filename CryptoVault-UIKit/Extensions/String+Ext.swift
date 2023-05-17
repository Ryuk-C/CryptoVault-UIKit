//
//  String+Ext.swift
//  CryptoVault-UIKit
//
//  Created by Cuma on 17/05/2023.
//

import Foundation

extension StringProtocol {
    var firstUppercased: String { prefix(1).uppercased() + dropFirst() }
    var firstCapitalized: String { prefix(1).capitalized + dropFirst() }
}
