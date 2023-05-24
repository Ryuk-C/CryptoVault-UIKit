//
//  MockService.swift
//  CryptoVault-UIKitTests
//
//  Created by Cuma on 24/05/2023.
//

import Alamofire
@testable import CryptoVault_UIKit

final class MockService: ServiceProtocol {
    
    var invokedFetchMarketList = false
    var invokedFetchMarketListCount = 0
    
    func fetchCryptoMarketList(currency: CryptoVault_UIKit.Currencies, completion: @escaping (Result<CryptoVault_UIKit.CryptoMarketList?, Alamofire.AFError>) -> Void) {
        
        invokedFetchMarketList = true
        invokedFetchMarketListCount += 1

    }
    
    func fetchCryptoDetail(id: String, completion: @escaping (Result<CryptoVault_UIKit.CryptoDetailModel?, Alamofire.AFError>) -> Void) {
        
    }
    
    func fetchCustomCryptoMarketList(ids: String, currency: CryptoVault_UIKit.Currency, completion: @escaping (Result<CryptoVault_UIKit.CustomCryptoMarketModel?, Alamofire.AFError>) -> Void) {
        
    }
    
    func fetchNewsList(language: CryptoVault_UIKit.Languages, completion: @escaping (Result<CryptoVault_UIKit.NewsModel?, Alamofire.AFError>) -> Void) {
        
    }
    
    
    
    
}
