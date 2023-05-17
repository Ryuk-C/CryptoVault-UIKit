//
//  FavoriteScreen.swift
//  CryptoVault-UIKit
//
//  Created by Cuma on 07/05/2023.
//

import UIKit

protocol FavoriteScreenDelegate: AnyObject {
    func configureVC()
    
}

final class FavoriteScreen: UIViewController {

    let viewModel = FavoriteViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
        

    }
    
}

extension FavoriteScreen: FavoriteScreenDelegate {
    func configureVC() {
        
        title = "Favorites"
        view.backgroundColor = UIColor(named: "BackgroundColor")
        
    }
    
    
    
}
