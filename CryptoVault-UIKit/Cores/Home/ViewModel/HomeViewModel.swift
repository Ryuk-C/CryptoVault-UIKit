//
//  HomeViewModel.swift
//  CryptoVault-UIKit
//
//  Created by Cuma on 14/05/2023.
//

import Foundation

protocol HomeViewModelProtocol {
    var view: HomeScreenDelegate? {get set}
    func viewDidLoad()
    func fetchCryptoList()
}

final class HomeViewModel {
    
    var view: HomeScreenDelegate?
    private var service = Service()
    var cryptoList: [CryptoMarketListElement] = []
}

extension HomeViewModel: HomeViewModelProtocol {

    func viewDidLoad() {
        view?.configureVC()
        fetchCryptoList()
        view?.configureCollectionView()
    }
    
    func fetchCryptoList() {
        view?.setLoading(isLoading: true)
        service.fetchCryptoMarketList(currency: Currencies.USD, completion: { [weak self] result in
            guard let self = self else {return}
        
            switch result {
                
            case .success(let crypto):
                DispatchQueue.main.async {
                    self.cryptoList.append(contentsOf: crypto ?? [])
                    //dump(self.cryptoList)
                    self.view?.reloadCollectionView()
                    self.view?.setLoading(isLoading: false)
                }
            case .failure(let failure):
                self.view?.dataError()
            }
            
        })
    }
    
    func search(_ text: String?) {
        
       
    }
    
}
