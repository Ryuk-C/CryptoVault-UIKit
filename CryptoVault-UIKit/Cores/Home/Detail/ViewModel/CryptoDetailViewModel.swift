//
//  CryptoDetailViewModel.swift
//  CryptoVault-UIKit
//
//  Created by Cuma on 14/05/2023.
//

import Foundation

protocol CryptoDetailViewModelProtocol {
    var view: CryptoDetailScreen? { get set }
    func viewDidLoad(id: String)
    func fetchDetail(id: String)
    func checkFav() -> Bool
    func addFavorite()
}

final class CryptoDetailViewModel {

    weak var view: CryptoDetailScreen?
    private var service = Service()
    private var coreDataManager = CryptoCoreDataManager()
    var cryptoDetailList: [CryptoDetailModel] = []
    var cryptoId : String?
    
    var usdPrice: Double = 0.0
    var usdPriceChange: Double = 0.0
    
    var eurPrice: Double = 0.0
    var eurPriceChange: Double = 0.0
    
    var tryPrice: Double = 0.0
    var tryPriceChange: Double = 0.0

}

extension CryptoDetailViewModel: CryptoDetailViewModelProtocol {
    
    func addFavorite() {
        if let cryptoId, !checkFav() {
            coreDataManager.addCeyptoCurrency(id: cryptoId)
        } else {
            if let index = coreDataManager.getCryptoCurrencies()?.firstIndex(where: { $0.id == self.cryptoId }) {
                coreDataManager.deleteCryptoCurrency(index: index)
            }
        }
    }
    
    func checkFav() -> Bool {
        if coreDataManager.getCryptoCurrencies()?.contains(where: {$0.id == self.cryptoId}) == true {
            return true
        }else{
            return false
        }
    }
    

    func viewDidLoad(id: String) {
        view?.configureVC()
        fetchDetail(id: id)
    }

    func fetchDetail(id: String) {
        view?.setLoading(isLoading: true)
        service.fetchCryptoDetail(id: id, completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let detail):
                DispatchQueue.main.async {
                    guard let detail = detail else {
                        self.view?.setLoading(isLoading: false)
                        self.view?.dataError()
                        return
                    }
                                        
                    self.cryptoDetailList = [detail]
                    
                    for i in self.cryptoDetailList {
                        
                        if let usd = i.marketData?.currentPrice?["usd"]{
                            self.usdPrice = usd
                        }
                        
                        if let usdChange = i.marketData?.priceChangePercentage24HInCurrency?["usd"]{
                            self.usdPriceChange = usdChange
                        }
                        
                        if let eur = i.marketData?.currentPrice?["eur"]{
                            self.eurPrice = eur
                        }
                        
                        if let eurChange = i.marketData?.priceChangePercentage24HInCurrency?["eur"]{
                            self.eurPriceChange = eurChange
                        }
                        
                        if let tryV = i.marketData?.currentPrice?["try"]{
                            self.tryPrice = tryV
                        }
                        
                        if let tryChange = i.marketData?.priceChangePercentage24HInCurrency?["try"]{
                            self.tryPriceChange = tryChange
                        }
                    }
                    
                    self.cryptoId = detail.id
                    self.view?.setLoading(isLoading: false)
                    self.view?.prepareFavButton()
                    self.view?.createComponents()
                }
            case .failure(let failure):
                print(failure)
                self.view?.dataError()
            }

        })

    }

}
