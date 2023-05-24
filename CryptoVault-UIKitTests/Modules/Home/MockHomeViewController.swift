//
//  MockHomeViewController.swift
//  CryptoVault-UIKitTests
//
//  Created by Cuma on 24/05/2023.
//

@testable import CryptoVault_UIKit

final class MockViewController: HomeScreenDelegate {

    var invokedSetLoading = false
    var invokedSetLoadingCount = 0
    var invokedSetLoadingParameters: (isLoading: Bool, Void)?
    var invokedSetLoadingParametersList = [(isLoading: Bool, Void)]()

    func setLoading(isLoading: Bool) {
        invokedSetLoading = true
        invokedSetLoadingCount += 1
        invokedSetLoadingParameters = (isLoading, ())
        invokedSetLoadingParametersList.append((isLoading, ()))
    }

    var invokedDataError = false
    var invokedDataErrorCount = 0

    func dataError() {
        invokedDataError = true
        invokedDataErrorCount += 1
    }

    var invokedConfigureVC = false
    var invokedConfigureVCCount = 0

    func configureVC() {
        invokedConfigureVC = true
        invokedConfigureVCCount += 1
    }

    var invokedConfigureCollectionView = false
    var invokedConfigureCollectionViewCount = 0

    func configureCollectionView() {
        invokedConfigureCollectionView = true
        invokedConfigureCollectionViewCount += 1
    }

    var invokedReloadCollectionView = false
    var invokedReloadCollectionViewCount = 0

    func reloadCollectionView() {
        invokedReloadCollectionView = true
        invokedReloadCollectionViewCount += 1
    }

    var invokedNavigateToDetailScreen = false
    var invokedNavigateToDetailScreenCount = 0
    var invokedNavigateToDetailScreenParameters: (id: String, pageTitle: String, price: String)?
    var invokedNavigateToDetailScreenParametersList = [(id: String, pageTitle: String, price: String)]()

    func navigateToDetailScreen(id: String, pageTitle: String, price: String) {
        invokedNavigateToDetailScreen = true
        invokedNavigateToDetailScreenCount += 1
        invokedNavigateToDetailScreenParameters = (id, pageTitle, price)
        invokedNavigateToDetailScreenParametersList.append((id, pageTitle, price))
    }
}
