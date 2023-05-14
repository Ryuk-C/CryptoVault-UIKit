//
//  UICollectionView+Ext.swift
//  CryptoVault-UIKit
//
//  Created by Cuma on 12/05/2023.
//

import UIKit.UICollectionView

extension UICollectionView {
    func reloadOnMainThread() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
}
