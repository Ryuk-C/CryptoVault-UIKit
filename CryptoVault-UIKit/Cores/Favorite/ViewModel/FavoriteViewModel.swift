//
//  FavoriteViewModel.swift
//  CryptoVault-UIKit
//
//  Created by Cuma on 17/05/2023.
//

import Foundation

protocol FavoriteScreenProtocol {
    var view: FavoriteScreenDelegate? {get set}
    func viewDidLoad()
}

final class FavoriteViewModel {
    weak var view: FavoriteScreenDelegate?
    
    
}

extension FavoriteViewModel: FavoriteScreenProtocol {
    func viewDidLoad() {
        view?.configureVC()
    }
    
    
    
}
