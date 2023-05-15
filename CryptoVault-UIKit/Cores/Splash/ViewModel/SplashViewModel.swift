//
//  SplashVıewModel.swift
//  CryptoVault-UIKit
//
//  Created by Cuma on 07/05/2023.
//

import Foundation

protocol SplashViewModelProtocol {
    var view: SplashScreenDelegate? { get set }
    func viewDidLoad()
    func navigateToHomeScreen()
}

final class SplashViewModel {
    weak var view: SplashScreenDelegate?

}

extension SplashViewModel: SplashViewModelProtocol {

    func viewDidLoad() {
        view?.configureVC()
    }

    func navigateToHomeScreen() {

        view?.navigateToHome()

    }

}
