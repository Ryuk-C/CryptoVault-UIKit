//
//  InfoViewModel.swift
//  CryptoVault-UIKit
//
//  Created by Cuma on 12/05/2023.
//

import Foundation

protocol InfoViewModelProtocol {
    var view: InfoScreenDelegate? {get set}
    func viewDidLoad()
}

final class InfoViewModel {
    weak var view: InfoScreenDelegate?
}

extension InfoViewModel: InfoViewModelProtocol {
    func viewDidLoad() {
        view?.configureVC()
    }
    
    
}
