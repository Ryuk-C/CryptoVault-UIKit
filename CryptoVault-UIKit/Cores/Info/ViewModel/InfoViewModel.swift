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
    func setInfolistItems()
}

final class InfoViewModel {
    weak var view: InfoScreenDelegate?
    var contactSectionItems : [InfoItemsModel] = []
}

extension InfoViewModel: InfoViewModelProtocol {
    func viewDidLoad() {
        view?.configureVC()
        setInfolistItems()
        view?.configureCollectionView()
    }
    
    func setInfolistItems() {
        
        contactSectionItems.append(InfoItemsModel(id: "1", name: "Github"))
        contactSectionItems.append(InfoItemsModel(id: "2", name: "Linkedin"))
        contactSectionItems.append(InfoItemsModel(id: "3", name: "Mail"))
        
        view?.reloadCollectionView()
    }
    
}
