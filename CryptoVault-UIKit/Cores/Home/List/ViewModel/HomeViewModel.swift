//
//  HomeViewModel.swift
//  CryptoVault-UIKit
//
//  Created by Cuma on 14/05/2023.
//

import Foundation

protocol HomeViewModelProtocol {
    func viewDidLoad()
    func fetchCryptoList()
    func navigateToDetail(id: String, pageTitle: String, price: String)
}

final class HomeViewModel {

    private weak var view: HomeScreenDelegate?
    private var service: ServiceProtocol
    var cryptoList: [CryptoMarketListElement] = []
    
    init(view: HomeScreenDelegate, service: ServiceProtocol = Service.shared) {
        self.view = view
        self.service = service
    }
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
            guard let self = self else { return }
            switch result {
            case .success(let crypto):
                DispatchQueue.main.async {
                    self.cryptoList = crypto ?? []
                    self.view?.reloadCollectionView()
                    self.view?.setLoading(isLoading: false)
                }
                
            case .failure(let failure):
                self.view?.setLoading(isLoading: false)
                self.view?.dataError()
                print(failure)
            }
        })
    }

    func search(_ text: String?) {

        if let text = text, !text.isEmpty {
            let searchData = self.cryptoList.filter { $0.name.lowercased().contains(text.lowercased()) }
            self.cryptoList = searchData
            self.view?.reloadCollectionView()
        } else {

            fetchCryptoList()
        }
    }

    func navigateToDetail(id: String, pageTitle: String, price: String) {
        view?.navigateToDetailScreen(id: id, pageTitle: pageTitle, price: price)
    }
}
