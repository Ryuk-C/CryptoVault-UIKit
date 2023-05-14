//
//  InfoScreen.swift
//  CryptoVault-UIKit
//
//  Created by Cuma on 07/05/2023.
//

import UIKit

protocol InfoScreenDelegate: AnyObject {
    func configureVC()
    func configureCollectionView()
    func reloadCollectionView()
}

final class InfoScreen: UIViewController {

    var viewModel = InfoViewModel()
    private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
        
    }

}

extension InfoScreen: InfoScreenDelegate {
    
    func configureVC() {
        
        title = "Info"
        view.backgroundColor = UIColor(named: "BackgroundColor")

        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.headerMode = .supplementary
        configuration.backgroundColor = .white
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.addSubview(collectionView)
        
    }
    
    func configureCollectionView() {
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.register(InfoCells.self, forCellWithReuseIdentifier: InfoCells.reuseID)
        
        collectionView.snp.makeConstraints { make in
            
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
    }
    
    func reloadCollectionView() {
        
        collectionView.reloadOnMainThread()
        
    }
    
}

extension InfoScreen: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.contactSectionItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InfoCells.reuseID, for: indexPath) as! InfoCells
               
        cell.design(itemName: viewModel.contactSectionItems[indexPath.row].name)
        return cell
    }
    
}
