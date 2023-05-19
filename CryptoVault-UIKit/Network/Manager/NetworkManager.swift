//
//  NetworkManager.swift
//  CryptoVault-UIKit
//
//  Created by Cuma on 14/05/2023.
//

import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
}

extension NetworkManager {

    func sendRequest<T: Codable>(
        type: T.Type,
        url: String,
        method: HTTPMethod,
        parameters: Parameters? = nil,
        completion: @escaping ((Result<T, AFError>) -> Void)) {

        AF.request(url,
            method: method,
            parameters: parameters,
            encoding: URLEncoding.default)
            .validate()
            .responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
