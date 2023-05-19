//
//  NewsDetailViewModel.swift
//  CryptoVault-UIKit
//
//  Created by Cuma on 17/05/2023.
//

import Foundation

protocol NewsDetailViewModelProtocol {
    var view: NewsDetailScreenDelegate? { get set }
    func viewDidLoad()
    func checkFav(id: String) -> Bool
    func addFavorite(id: String?, url: String, source: String, newsTitle: String, imageUrl: String)
}

final class NewsDetailViewModel {
    weak var view: NewsDetailScreenDelegate?
    var coreDataManager = NewsCoreDataManager()
}

extension NewsDetailViewModel: NewsDetailViewModelProtocol {

    func viewDidLoad() {
        view?.configureVC()
        view?.prepareFavButton()
    }

    func checkFav(id: String) -> Bool {
        if coreDataManager.getNews()?.contains(where: { $0.id == id }) == true {
            return true
        } else {
            return false
        }
    }

    func addFavorite(id: String?, url: String, source: String, newsTitle: String, imageUrl: String) {

        if let id, !checkFav(id: id) {
            coreDataManager.addNews(id: id, url: url, source: source, newsTitle: newsTitle, imageUrl: imageUrl)
        } else {
            if let index = coreDataManager.getNews()?.firstIndex(where: { $0.id == id }) {
                coreDataManager.deleteCryptoCurrency(index: index)
            }
        }

    }




}
