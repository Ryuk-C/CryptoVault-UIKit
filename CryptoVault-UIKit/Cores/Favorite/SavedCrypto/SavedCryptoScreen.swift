//
//  SavedCryptoScreen.swift
//  CryptoVault-UIKit
//
//  Created by Cuma on 17/05/2023.
//

import UIKit

protocol SavedCryptoScreenDelegate: AnyObject {
    func setLoading(isLoading: Bool)
    func dataError()
    func configureVC()
    func configureCollectionView()
    func reloadCollectionView()
    func navigateToDetailScreen(id: String, pageTitle: String, price: String)
}

final class SavedCryptoScreen: UIViewController {

    private var collectionView: UICollectionView!
    private lazy var activityIndicator = UIActivityIndicatorView()

    let viewModel = SavedCryptoViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        viewModel.view = self
        viewModel.viewDidLoad()
    }

}

extension SavedCryptoScreen: SavedCryptoScreenDelegate {

    func configureVC() {

        view.backgroundColor = UIColor(named: "BackgroundColor")

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createHomeFlowLayout())
        collectionView.backgroundColor = UIColor(named: "BackgroundColor")

        view.addSubview(collectionView)
        view.addSubview(activityIndicator)

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        activityIndicator.snp.makeConstraints { make in

            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)

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

            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(15)
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

extension SavedCryptoScreen: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        print("xxx")
        print(viewModel.cryptoList.count)
        print("xxx")
        return viewModel.cryptoList.count

    }



    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CryptoCurrencyCell.reuseID, for: indexPath) as! CryptoCurrencyCell

        cell.design(imageUrl: viewModel.cryptoList[indexPath.row].image ?? "",
            name: viewModel.cryptoList[indexPath.row].name ?? "",
            symbol: viewModel.cryptoList[indexPath.row].symbol ?? "",
            price: String(viewModel.cryptoList[indexPath.row].currentPrice),
            changes: String(format: "%.2f", viewModel.cryptoList[indexPath.row].priceChangePercentage24H ?? "")
        )

        cell.backgroundColor = .white
        cell.layer.borderColor = UIColor.gray.withAlphaComponent(0.4).cgColor
        cell.layer.borderWidth = 0.6
        cell.layer.cornerRadius = 8
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.navigateToDetail(
            id: viewModel.cryptoList[indexPath.item].id ?? "",
            pageTitle: viewModel.cryptoList[indexPath.item].name ?? "",
            price: String(viewModel.cryptoList[indexPath.item].currentPrice)
        )
    }
}
