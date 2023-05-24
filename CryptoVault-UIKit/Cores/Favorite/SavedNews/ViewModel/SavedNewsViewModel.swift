//
//  NewsViewModel.swift
//  CryptoVault-UIKit
//
//  Created by Cuma on 19/05/2023.
//

import Foundation

protocol SavedNewsViewModelProtocol {
    var view: SavedNewsScreenDelegate? { get set }
    func viewDidLoad()
    func fetchNewsList()
    func navigateToDetailScreen(id: String, url: String, source: String, newsTitle: String, urlToImage: String, category: String)
}


final class SavedNewsViewModel {
    var view: SavedNewsScreenDelegate?
    let coreDataManager = NewsCoreDataManager()
    var savedNewsList: [NewsDB] = []
}

extension SavedNewsViewModel: SavedNewsViewModelProtocol {
    
    func viewDidLoad() {
        view?.configureVC()
        view?.configureCollectionView()
        fetchNewsList()
    }
    
    func fetchNewsList() {
        
        view?.setLoading(isLoading: true)
        
        savedNewsList = coreDataManager.getNews() ?? []

        switch savedNewsList.isEmpty {
            
        case true:
            
            savedNewsList = []
            view?.setEmptyOrNot(isEmpty: true)
            
        case false:

            self.view?.reloadCollectionView()
            view?.setEmptyOrNot(isEmpty: false)
        }
        
        view?.setLoading(isLoading: false)

        
    }
    
    func navigateToDetailScreen(id: String, url: String, source: String, newsTitle: String, urlToImage: String, category: String) {
        view?.navigateToDetailScreen(id: id, url: url, source: source, newsTitle: newsTitle, urlToImage: urlToImage, category: category)
    }
}
