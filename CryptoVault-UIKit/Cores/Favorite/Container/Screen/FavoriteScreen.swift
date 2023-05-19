//
//  FavoriteScreen.swift
//  CryptoVault-UIKit
//
//  Created by Cuma on 07/05/2023.
//

import UIKit

protocol FavoriteScreenDelegate: AnyObject {
    func configureVC()

}

final class FavoriteScreen: UIViewController {

    let viewModel = FavoriteViewModel()
    
    let cryptoScreen = SavedCryptoScreen()
    let newsScreen = SavedNewsScreen()
    
    var newsCreated = false
    
    private let buttonTitles: [String] = ["Crypto", "News"]
    private lazy var segmentedControl: CustomSegmetedControl = CustomSegmetedControl(buttonTitles: buttonTitles)

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()


    }

    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
}

extension FavoriteScreen: FavoriteScreenDelegate {
    func configureVC() {

        title = "Favorites"
        view.backgroundColor = UIColor(named: "BackgroundColor")
        
        view.addSubview(segmentedControl)
        
        segmentedControl.delegate = self
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        segmentedControl.snp.makeConstraints { make in
            
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
                .offset(10)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            
        }

        addChild(cryptoScreen)
        cryptoScreen.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cryptoScreen.view)
        
        cryptoScreen.view.snp.makeConstraints{ make in
            
            make.top.equalTo(segmentedControl.snp.bottom)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            
        }
        
        cryptoScreen.didMove(toParent: self)
        
    }


}

extension FavoriteScreen: CustomSegmetedControlDelegate {
    
    func buttonPressed(buttonTitlesIndex: Int, title: String?) {
        
        newsScreen.view.isHidden = true
        cryptoScreen.view.isHidden = true

        if buttonTitlesIndex == 0 {
            
            cryptoScreen.view.isHidden = false
            
        }else{
            
            if newsCreated == false {
                                
                addChild(newsScreen)
                newsScreen.view.translatesAutoresizingMaskIntoConstraints = false
                view.addSubview(newsScreen.view)
                
                newsScreen.view.snp.makeConstraints{ make in
                    
                    make.top.equalTo(segmentedControl.snp.bottom)
                    make.leading.equalTo(view.snp.leading)
                    make.trailing.equalTo(view.snp.trailing)
                    make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
                    
                }
                
                newsScreen.didMove(toParent: self)
                
                newsCreated = true
            }
            
            newsScreen.view.isHidden = false
        }
        
        
    }
}
