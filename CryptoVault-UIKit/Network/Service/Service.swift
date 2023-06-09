//
//  Service.swift
//  CryptoVault-UIKit
//
//  Created by Cuma on 14/05/2023.
//

import Alamofire

protocol ServiceProtocol {

    func fetchCryptoMarketList(currency: Currencies, completion: @escaping (Result<CryptoMarketList?, AFError>) -> Void)
    func fetchCryptoDetail(id: String, completion: @escaping (Result<CryptoDetailModel?, AFError>) -> Void)
    func fetchCustomCryptoMarketList(
        ids: String,
        currency: Currency,
        completion: @escaping (Result<CustomCryptoMarketModel?, AFError>) -> Void)

    func fetchNewsList(language: Languages, completion: @escaping (Result<NewsModel?, AFError>) -> Void)
}

final class Service {
    static let shared = Service()
}

extension Service: ServiceProtocol {
    
    func fetchCryptoMarketList(
        currency: Currencies,
        completion: @escaping (Result<CryptoMarketList?, Alamofire.AFError>) -> Void) {

        let url = CryptoEndPoints.fetchAllList.url

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

    func fetchCryptoDetail(id: String, completion: @escaping (Result<CryptoDetailModel?, Alamofire.AFError>) -> Void) {

        let url = CryptoEndPoints.fetchCryptoDetail.url + id

        NetworkManager.shared.sendRequest(type: CryptoDetailModel.self, url: url, method: .get, parameters: nil,
            completion: { response in

                switch response {
                case .success(let success):
                    completion(.success(success))

                case .failure(let failure):
                    completion(.failure(failure))
                }
            })
    }

    func fetchCustomCryptoMarketList(
        ids: String,
        currency: Currency,
        completion: @escaping (Result<CustomCryptoMarketModel?, Alamofire.AFError>) -> Void) {

        let url = CryptoEndPoints.fetchCustomList.url

        let parameters: Parameters = [
            "ids": ids,
            "vs_currency": currency
        ]

        NetworkManager.shared.sendRequest(
            type: CustomCryptoMarketModel.self,
            url: url, method: .get,
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

    func fetchNewsList(language: Languages, completion: @escaping (Result<NewsModel?, Alamofire.AFError>) -> Void) {

        let url = NewsEndPoints.fetchAllNews.url

        let parameters: Parameters = [
            "Apikey": NewsEndPoints.fetchAllNews.apiKey,
            "lang": language
        ]

        NetworkManager.shared.sendRequest(type: NewsModel.self, url: url, method: .get, parameters: parameters,
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
