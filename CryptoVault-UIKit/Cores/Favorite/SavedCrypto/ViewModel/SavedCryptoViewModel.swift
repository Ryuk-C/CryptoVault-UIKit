//
//  SavedCryptoViewModel.swift
//  CryptoVault-UIKit
//
//  Created by Cuma on 19/05/2023.
//

import Foundation

protocol SavedCryptoViewModelProtocol {
    var view: SavedCryptoScreenDelegate? { get set }
    func viewDidLoad()
    func fetchCryptoList(ids: String)
    func fetchSavedCryptoList()
    func navigateToDetail(id: String, pageTitle: String, price: String)
}

final class SavedCryptoViewModel {

    weak var view: SavedCryptoScreenDelegate?
    let service = Service()
    let coreDataManager = CryptoCoreDataManager()
    var cryptoList: [CustomCryptoMarketModelElement] = []
    var savedCryptoList: [CryptoDB] = []
}

extension SavedCryptoViewModel: SavedCryptoViewModelProtocol {

    func viewDidLoad() {
        view?.configureVC()
        fetchSavedCryptoList()
        view?.configureCollectionView()
    }
    
    func fetchSavedCryptoList() {
        
        savedCryptoList = coreDataManager.getCryptoCurrencies() ?? []
        
        switch savedCryptoList.isEmpty {
            
        case true:
            
            cryptoList = []
            view?.setEmptyOrNot(isEmpty: true)
            
        case false:

            view?.setEmptyOrNot(isEmpty: false)
            var idList = ""

            for i in savedCryptoList {
                
                idList.append("\(i.id + ",")")
            }
                    
            fetchCryptoList(ids: idList)
        }
    }
    
    func fetchCryptoList(ids: String) {
        view?.setLoading(isLoading: true)
        service.fetchCustomCryptoMarketList(ids: ids, currency: Currency.usd, completion: { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let success):
                DispatchQueue.main.async {
                    dump(self.cryptoList)
                    self.cryptoList = success ?? []
                    self.view?.reloadCollectionView()
                    self.view?.setLoading(isLoading: false)
                }
                
            case .failure(let error):
                self.view?.setLoading(isLoading: false)
                self.view?.dataError()
            }
        }
    )
    }

    func navigateToDetail(id: String, pageTitle: String, price: String) {
        view?.navigateToDetailScreen(id: id, pageTitle: pageTitle, price: price)
    }
}
