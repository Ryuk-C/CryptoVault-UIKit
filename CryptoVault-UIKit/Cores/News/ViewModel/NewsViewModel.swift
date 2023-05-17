//
//  NewsViewModel.swift
//  CryptoVault-UIKit
//
//  Created by Cuma on 17/05/2023.
//

import Foundation

protocol NewsViewModelProtocol {
    var view: NewsScreenDelegate? {get set}
    func viewDidLoad()
    func fetchNews()
}

final class NewsViewModel {
    
    weak var view: NewsScreenDelegate?
    private var service = Service()
    var newsList: [Datum] = []

}

extension NewsViewModel: NewsViewModelProtocol {
    
    func viewDidLoad() {
        view?.configureVC()
        fetchNews()
        view?.configureCollectionView()
    }
    
    func fetchNews() {
        view?.setLoading(isLoading: true)
        service.fetchNewsList(language: Languages.EN, completion: {[weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let news):
                DispatchQueue.main.async {
                    self.newsList = news?.data ?? []
                    self.view?.reloadCollectionView()
                    self.view?.setLoading(isLoading: false)
                }
            case .failure(let failure):
                self.view?.setLoading(isLoading: false)
                self.view?.dataError()
            }
        })
    }
    
}
