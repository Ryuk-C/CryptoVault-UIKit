//
//  HomeScreen.swift
//  CryptoVault-UIKit
//
//  Created by Cuma on 07/05/2023.
//

import SnapKit
import UIKit

protocol HomeScreenDelegate: AnyObject {
    func setLoading(isLoading: Bool)
    func dataError()
    func configureVC()
    func configureCollectionView()
    func reloadCollectionView()
}

final class HomeScreen: UIViewController {

    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Type here to search"
        searchBar.searchBarStyle = .prominent
        return searchBar
    }()
    
    private var collectionView: UICollectionView!

    let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.view = self
        viewModel.viewDidLoad()
    }

}

extension HomeScreen: HomeScreenDelegate {
  
    func configureVC() {
        
        title = "Home"
        view.backgroundColor = UIColor(named: "BackgroundColor")
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createHomeFlowLayout())
        collectionView.backgroundColor = UIColor(named: "BackgroundColor")

        view.addSubview(searchBar)
        view.addSubview(collectionView)
        
        searchBar.delegate = self
        searchBar.backgroundImage = UIImage()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.snp.leading).offset(5)
            make.trailing.equalTo(view.snp.trailing).inset(5)
        }
        
        
        

    }
    
    func setLoading(isLoading: Bool) {
        
    }
    
    func dataError() {
        
    }
    
    func configureCollectionView() {
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CryptoCurrencyCell.self, forCellWithReuseIdentifier: CryptoCurrencyCell.reuseID)
        
        collectionView!.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)

        collectionView.snp.makeConstraints {make in
            
            make.top.equalTo(searchBar.snp.bottom).offset(10)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            
        }
    }
    
    func reloadCollectionView() {
        collectionView.reloadOnMainThread()
    }
}

extension HomeScreen: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewModel.cryptoList.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CryptoCurrencyCell.reuseID, for: indexPath) as! CryptoCurrencyCell
        
        cell.design(imageUrl: viewModel.cryptoList[indexPath.row].image, name: viewModel.cryptoList[indexPath.row].name)
        
        cell.backgroundColor = .white
        cell.layer.borderColor = UIColor.gray.withAlphaComponent(0.7).cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        
        return cell
    }
}

extension HomeScreen: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

    }
}