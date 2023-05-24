//
//  MockCryptoDetailViewController.swift
//  CryptoVault-UIKitTests
//
//  Created by Cuma on 24/05/2023.
//

@testable import CryptoVault_UIKit

final class MockCryptoDetailScreen: CryptoDetailDelegate {

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

    var invokedCreateComponents = false
    var invokedCreateComponentsCount = 0

    func createComponents() {
        invokedCreateComponents = true
        invokedCreateComponentsCount += 1
    }

    var invokedPrepareFavButton = false
    var invokedPrepareFavButtonCount = 0

    func prepareFavButton() {
        invokedPrepareFavButton = true
        invokedPrepareFavButtonCount += 1
    }
}
