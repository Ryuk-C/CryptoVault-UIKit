//
//  UIHelper.swift
//  CryptoVault-UIKit
//
//  Created by Cuma on 12/05/2023.
//

import UIKit

enum UIHelper {
    static func createHomeFlowLayout() -> UICollectionViewFlowLayout {
        
        let layout = UICollectionViewFlowLayout()
        let itemWidth = CGFloat.dWidth
        
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: itemWidth - 20, height: itemWidth * 0.2)
        
        layout.minimumLineSpacing = 15
        
        return layout
    }
}
