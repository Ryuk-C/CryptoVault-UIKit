//
//  NewsDetailViewModel.swift
//  CryptoVault-UIKit
//
//  Created by Cuma on 17/05/2023.
//

import Foundation

protocol NewsDetailViewModelProtocol {
    var view: NewsDetailScreenDelegate? {get set}
    func viewDidLoad()
    
}

final class NewsDetailViewModel {
    var view: NewsDetailScreenDelegate?
    
    
}

extension NewsDetailViewModel: NewsDetailViewModelProtocol {
    
    func viewDidLoad() {
        view?.configureVC()
    }
    
    
    
    
}
