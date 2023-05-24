//
//  MockService.swift
//  CryptoVault-UIKitTests
//
//  Created by Cuma on 24/05/2023.
//

import Alamofire
@testable import CryptoVault_UIKit

final class MockService: ServiceProtocol {

    var invokedFetchCryptoMarketList = false
    var invokedFetchCryptoMarketListCount = 0
    var invokedFetchCryptoMarketListParameters: (currency: Currencies, Void)?
    var invokedFetchCryptoMarketListParametersList = [(currency: Currencies, Void)]()
    var stubbedFetchCryptoMarketListCompletionResult: (Result<CryptoMarketList?, AFError>, Void)?

    func fetchCryptoMarketList(
        currency: Currencies,
        completion: @escaping (Result<CryptoMarketList?, AFError>) -> Void) {
        invokedFetchCryptoMarketList = true
        invokedFetchCryptoMarketListCount += 1
        invokedFetchCryptoMarketListParameters = (currency, ())
        invokedFetchCryptoMarketListParametersList.append((currency, ()))
        if let result = stubbedFetchCryptoMarketListCompletionResult {
            completion(result.0)
        }
    }

    var invokedFetchCryptoDetail = false
    var invokedFetchCryptoDetailCount = 0
    var invokedFetchCryptoDetailParameters: (id: String, Void)?
    var invokedFetchCryptoDetailParametersList = [(id: String, Void)]()
    var stubbedFetchCryptoDetailCompletionResult: (Result<CryptoDetailModel?, AFError>, Void)?

    func fetchCryptoDetail(
        id: String,
        completion: @escaping (Result<CryptoDetailModel?, AFError>) -> Void) {
        invokedFetchCryptoDetail = true
        invokedFetchCryptoDetailCount += 1
        invokedFetchCryptoDetailParameters = (id, ())
        invokedFetchCryptoDetailParametersList.append((id, ()))

        if let result = stubbedFetchCryptoDetailCompletionResult {
            completion(result.0)
        }
    }

    var invokedFetchCustomCryptoMarketList = false
    var invokedFetchCustomCryptoMarketListCount = 0
    var invokedFetchCustomCryptoMarketListParameters: (ids: String, currency: Currency)?
    var invokedFetchCustomCryptoMarketListParametersList = [(ids: String, currency: Currency)]()
    var stubbedFetchCustomCryptoMarketListCompletionResult: (Result<CustomCryptoMarketModel?, AFError>, Void)?

    func fetchCustomCryptoMarketList(
        ids: String,
        currency: Currency,
        completion: @escaping (Result<CustomCryptoMarketModel?, AFError>) -> Void) {
        invokedFetchCustomCryptoMarketList = true
        invokedFetchCustomCryptoMarketListCount += 1
        invokedFetchCustomCryptoMarketListParameters = (ids, currency)
        invokedFetchCustomCryptoMarketListParametersList.append((ids, currency))
        if let result = stubbedFetchCustomCryptoMarketListCompletionResult {
            completion(result.0)
        }
    }

    var invokedFetchNewsList = false
    var invokedFetchNewsListCount = 0
    var invokedFetchNewsListParameters: (language: Languages, Void)?
    var invokedFetchNewsListParametersList = [(language: Languages, Void)]()
    var stubbedFetchNewsListCompletionResult: (Result<NewsModel?, AFError>, Void)?

    func fetchNewsList(
        language: Languages,
        completion: @escaping (Result<NewsModel?, AFError>) -> Void) {
        invokedFetchNewsList = true
        invokedFetchNewsListCount += 1
        invokedFetchNewsListParameters = (language, ())
        invokedFetchNewsListParametersList.append((language, ()))
        if let result = stubbedFetchNewsListCompletionResult {
            completion(result.0)
        }
    }
}
