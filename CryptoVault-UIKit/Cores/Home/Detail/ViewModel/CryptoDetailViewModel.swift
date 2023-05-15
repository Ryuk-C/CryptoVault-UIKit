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
}

final class CryptoDetailViewModel {

    weak var view: CryptoDetailScreen?
    private var service = Service()
    var cryptoDetailList: [CryptoDetailModel] = []
}

extension CryptoDetailViewModel: CryptoDetailViewModelProtocol {

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
                    self.cryptoDetailList = detail ?? []
                    //self.view?.reloadCollectionView()
                    self.view?.setLoading(isLoading: false)
                    print("success")
                    print(detail)
                }
            case .failure(let failure):
                print("error")
                print(failure)
                self.view?.dataError()
            }

        })

    }

}
