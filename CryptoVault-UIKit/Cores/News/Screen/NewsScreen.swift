//
//  NewsScreen.swift
//  CryptoVault-UIKit
//
//  Created by Cuma on 07/05/2023.
//

import SnapKit
import UIKit

protocol NewsScreenDelegate: AnyObject {
    func setLoading(isLoading: Bool)
    func dataError()
    func configureVC()
    func configureCollectionView()
    func reloadCollectionView()
}

final class NewsScreen: UIViewController {
    
    let viewModel = NewsViewModel()
    
    private var collectionView: UICollectionView!
    private lazy var activityIndicator = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }

}

extension NewsScreen: NewsScreenDelegate {
    
    func configureVC() {
        
        title = "News"
        view.backgroundColor = UIColor(named: "BackgroundColor")
        
        let layout = DynamicCollectionViewLayout()
        layout.delegate = self
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor(named: "BackgroundColor")

        view.addSubview(activityIndicator)
        view.addSubview(collectionView)
        
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
        collectionView.register(NewsCell.self, forCellWithReuseIdentifier: NewsCell.reuseID)

        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)

        collectionView.snp.makeConstraints { make in

            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)

        }
    }
    
    func reloadCollectionView() {
        
        collectionView.reloadOnMainThread()

    }
    
}

extension NewsScreen: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.newsList.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: NewsCell.reuseID, for: indexPath) as! NewsCell

        cell.design(
            source: viewModel.newsList[indexPath.row].source,
            imageUrl: viewModel.newsList[indexPath.row].imageurl,
            title: viewModel.newsList[indexPath.row].title,
            date: viewModel.newsList[indexPath.row].categories)
        
        cell.backgroundColor = .white
        cell.layer.borderColor = UIColor.gray.withAlphaComponent(0.4).cgColor
        cell.layer.borderWidth = 0.75
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true

        return cell
    }
    
}

extension NewsScreen: DynamicCollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath, cellWidth: CGFloat) -> CGFloat {

        let imageHeight = CGFloat(125)
        let sourceLabelHeight = sourceRequiredHeight(text: viewModel.newsList[indexPath.row].source, cellWidth: (cellWidth - 10))
        
        let titleLableHeight = requiredHeight(text: viewModel.newsList[indexPath.row].title, cellWidth: (cellWidth - 10))
        
        let categoryLableHeight = sourceRequiredHeight(text: viewModel.newsList[indexPath.row].categories, cellWidth: (cellWidth - 10))
        
        let spacing = CGFloat(35)
        
        return (imageHeight + sourceLabelHeight + titleLableHeight + categoryLableHeight + spacing)
        
    }
    
    func sourceRequiredHeight(text:String , cellWidth : CGFloat) -> CGFloat {

        let font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.semibold)
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: CGFloat.dWidth / 2 - 30, height: .greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.lineBreakMode = .byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.height

    }
    
    func requiredHeight(text:String , cellWidth : CGFloat) -> CGFloat {

        let font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.bold)
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: CGFloat.dWidth / 2 - 30, height: .greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.lineBreakMode = .byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.height

    }
    
    func calcSourceLabelHeight(text:String , cellWidth : CGFloat) -> CGFloat {

        let font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.bold)
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: CGFloat.dWidth / 2 - 30, height: .greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.lineBreakMode = .byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.height

    }
    
}
