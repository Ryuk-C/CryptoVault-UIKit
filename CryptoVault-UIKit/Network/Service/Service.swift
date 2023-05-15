//
//  Service.swift
//  CryptoVault-UIKit
//
//  Created by Cuma on 14/05/2023.
//

import Alamofire
import Foundation

protocol ServiceProtocol {

    func fetchCryptoMarketList(currency: Currencies, completion: @escaping (Result<CryptoMarketList?, AFError>) -> Void)
    func fetchCryptoDetail(id: String, completion: @escaping (Result<CryptoDetailList?, AFError>) -> Void)

}

final class Service: ServiceProtocol {

    func fetchCryptoMarketList(currency: Currencies, completion: @escaping (Result<CryptoMarketList?, Alamofire.AFError>) -> Void) {

        let url = Constants.BASE_URL

        let parameters: Parameters = [
            "vs_currency": Currency.usd
        ]

        NetworkManager.shared.sendRequest(type: CryptoMarketList.self, url: url, method: .get,
            parameters: parameters,
            completion: { response in

                switch response {
                case .success(let success):
                    completion(.success(success))
                case .failure(let failure):
                    completion(.failure(failure))
                }

            })

    }

    func fetchCryptoDetail(id: String, completion: @escaping (Result<CryptoDetailList?, Alamofire.AFError>) -> Void) {

        let url = Constants.DETAILS_BASE_URL + id

        NetworkManager.shared.sendRequest(type: CryptoDetailList.self, url: url, method: .get,
            completion: { response in

                switch response {
                case .success(let success):
                    completion(.success(success))
                case .failure(let failure):
                    completion(.failure(failure))
                }

            })
    }

}
