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
    func navigateToDetailScreen(id: String, pageTitle: String, price: String)
}

final class HomeScreen: UIViewController {

    private lazy var searchBar: UISearchBar = {

        let searchBar = UISearchBar()
        searchBar.placeholder = "Type here to search"
        searchBar.searchBarStyle = .prominent
        return searchBar

    }()

    private lazy var allCoinsTitle: UILabel = {

        let label = UILabel()
        label.text = "All Coins"
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.bold)
        label.textColor = .black.withAlphaComponent(0.70)
        label.textAlignment = .center
        return label

    }()

    private var collectionView: UICollectionView!
    private lazy var activityIndicator = UIActivityIndicatorView()

    let viewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.view = self
        viewModel.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
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
        view.addSubview(activityIndicator)
        view.addSubview(allCoinsTitle)

        searchBar.delegate = self
        searchBar.backgroundImage = UIImage()
        searchBar.translatesAutoresizingMaskIntoConstraints = false

        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.snp.leading).offset(5)
            make.trailing.equalTo(view.snp.trailing).inset(5)
        }

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        activityIndicator.snp.makeConstraints { make in

            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)

        }

        allCoinsTitle.translatesAutoresizingMaskIntoConstraints = false

        allCoinsTitle.snp.makeConstraints { make in

            make.top.equalTo(searchBar.snp.bottom).offset(10)
            make.leading.equalTo(view.snp.leading).offset(15)

        }

    }

    func setLoading(isLoading: Bool) {
        if isLoading {
            self.activityIndicator.startAnimating()
        } else {
            self.activityIndicator.stopAnimating()
        }

    }

    func dataError() {
        self.errorMessage(title: "Error", message: "Crypto currencies could not loaded! Please try again.")
    }

    func configureCollectionView() {

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CryptoCurrencyCell.self, forCellWithReuseIdentifier: CryptoCurrencyCell.reuseID)

        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)

        collectionView.snp.makeConstraints { make in

            make.top.equalTo(allCoinsTitle.snp.bottom).offset(15)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)

        }
    }

    func reloadCollectionView() {
        collectionView.reloadOnMainThread()
    }

    func navigateToDetailScreen(id: String, pageTitle: String, price: String) {

        DispatchQueue.main.async {
            self.navigationController?.pushViewController(
                CryptoDetailScreen(id: id, pageTitle: pageTitle, price: price), animated: true
            )
        }
    }
}

extension HomeScreen: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return viewModel.cryptoList.count

    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CryptoCurrencyCell.reuseID, for: indexPath) as! CryptoCurrencyCell

        cell.design(imageUrl: viewModel.cryptoList[indexPath.row].image,
            name: viewModel.cryptoList[indexPath.row].name,
            symbol: viewModel.cryptoList[indexPath.row].symbol,
            price: String(viewModel.cryptoList[indexPath.row].currentPrice),
            changes: String(format: "%.2f", viewModel.cryptoList[indexPath.row].priceChangePercentage24H)
        )

        cell.backgroundColor = .white
        cell.layer.borderColor = UIColor.gray.withAlphaComponent(0.4).cgColor
        cell.layer.borderWidth = 0.6
        cell.layer.cornerRadius = 8

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.navigateToDetail(
            id: viewModel.cryptoList[indexPath.item].id,
            pageTitle: viewModel.cryptoList[indexPath.item].name,
            price: String(viewModel.cryptoList[indexPath.item].currentPrice)
        )
    }
}

extension HomeScreen: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        viewModel.search(searchText)

    }
}
