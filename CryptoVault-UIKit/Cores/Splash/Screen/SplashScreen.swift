//
//  SplashScreen.swift
//  CryptoVault-UIKit
//
//  Created by Cuma on 07/05/2023.
//

import SnapKit
import UIKit

protocol SplashScreenDelegate: AnyObject {
    func configureVC()
    func navigateToHome()
}

final class SplashScreen: UIViewController {

    private lazy var bitcoinImage: UIImageView = {
        let image: UIImage? = UIImage(named: "SplashImage")
        let imageView = UIImageView()
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var developerName: UILabel = {
        let label = UILabel()
        label.text = "HAZNEDAR"
        label.font = UIFont(name: "Library3amsoft", size: 29)
        label.textColor = .blue
        label.textAlignment = .center
        return label
    }()

    var viewModel = SplashViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
        viewModel.navigateToHomeScreen()
    }
}

extension SplashScreen: SplashScreenDelegate {

    func configureVC() {
        
        view.backgroundColor = .white
 
        view.addSubview(bitcoinImage)
        view.addSubview(developerName)

        bitcoinImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }

        developerName.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }

        viewModel.navigateToHomeScreen()
    }

    func navigateToHome() {

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {

            let tabBar = UITabBarController()

            let homeViewController = UINavigationController(rootViewController: HomeScreen())
            let newsViewController = UINavigationController(rootViewController: NewsScreen())
            let favoritesViewController = UINavigationController(rootViewController: FavoriteScreen())
            let infoViewController = UINavigationController(rootViewController: InfoScreen())

            homeViewController.title = "Home"
            newsViewController.title = "News"
            favoritesViewController.title = "Favorite"
            infoViewController.title = "Info"

            tabBar.setViewControllers(
                [homeViewController, newsViewController, favoritesViewController, infoViewController],
                animated: false
            )

            guard let items = tabBar.tabBar.items else { return }

            let images = ["square.stack.3d.up.fill", "newspaper.fill", "bookmark.fill", "info.circle.fill"]

            for x in 0..<images.count {
                items[x].image = UIImage(systemName: images[x])
            }

            tabBar.modalPresentationStyle = .fullScreen

            self.present(tabBar, animated: true)
        }
    }
}
