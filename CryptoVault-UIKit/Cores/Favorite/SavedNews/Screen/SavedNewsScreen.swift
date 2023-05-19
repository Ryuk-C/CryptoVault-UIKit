//
//  SavedNewsScreen.swift
//  CryptoVault-UIKit
//
//  Created by Cuma on 17/05/2023.
//

import Lottie
import UIKit

protocol SavedNewsScreenDelegate: AnyObject {
    func setLoading(isLoading: Bool)
    func setEmptyOrNot(isEmpty: Bool)
    func dataError()
    func configureVC()
    func configureCollectionView()
    func reloadCollectionView()
    func navigateToDetailScreen(
        id: String, url: String, source: String, newsTitle: String, urlToImage: String, category: String
    )
}

final class SavedNewsScreen: UIViewController {

    private var animationView: LottieAnimationView = {
        var lottie = LottieAnimationView()
        lottie = .init(name: "anim_empty")
        lottie.contentMode = .scaleAspectFit
        lottie.loopMode = .loop
        lottie.animationSpeed = 0.75
        lottie.translatesAutoresizingMaskIntoConstraints = false
        lottie.play()
        return lottie
    }()
    
    private lazy var emptyListLabel: UILabel = {
        let label = UILabel()
        label.text = "There isn't any news in your favorite list."
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.semibold)
        label.textColor = .black.withAlphaComponent(0.8)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var collectionView: UICollectionView!
    private lazy var activityIndicator = UIActivityIndicatorView()

    let viewModel = SavedNewsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.view = self
        viewModel.viewDidLoad()
    }
}

extension SavedNewsScreen: SavedNewsScreenDelegate {
    
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
    
    func navigateToDetailScreen(id: String, url: String, source: String, newsTitle: String, urlToImage: String, category: String) {
        
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(
                NewsDetailScreen(
                id: id, url: url, source: source, newsTitle: newsTitle, urlToImage: urlToImage, newsCategory: category),
                animated: true
            )
        }
    }
    
    func setLoading(isLoading: Bool) {
        if isLoading {
            self.activityIndicator.startAnimating()
        } else {
            self.activityIndicator.stopAnimating()
        }
    }
    
    func setEmptyOrNot(isEmpty: Bool) {
        
        if isEmpty {
            
            view.addSubview(animationView)
            view.addSubview(emptyListLabel)
            
            animationView.snp.makeConstraints { make in
                make.top.equalTo(view.snp.top)
                make.leading.equalTo(view.snp.leading).offset(10)
                make.trailing.equalTo(view.snp.trailing).inset(10)
                make.bottom.equalTo(view.snp.bottom)
            }
            
            emptyListLabel.snp.makeConstraints { make in
                
                make.top.equalTo(animationView.snp.bottom).inset(100)
                make.leading.equalTo(view.snp.leading).offset(10)
                make.trailing.equalTo(view.snp.trailing).inset(10)
                make.bottom.equalTo(view.snp.bottom)
            }
        }
    }
    
    func dataError() {
        self.errorMessage(title: "Error", message: "News could not loaded! Please try again.")
    }
    
    func configureVC() {
        
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
}

extension SavedNewsScreen: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.savedNewsList.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: NewsCell.reuseID, for: indexPath) as! NewsCell

        cell.design(
            source: viewModel.savedNewsList[indexPath.row].source ?? "",
            imageUrl: viewModel.savedNewsList[indexPath.row].imageUrl ?? "",
            title: viewModel.savedNewsList[indexPath.row].title ?? "",
            date: viewModel.savedNewsList[indexPath.row].category ?? "")

        cell.backgroundColor = .white
        cell.layer.borderColor = UIColor.gray.withAlphaComponent(0.4).cgColor
        cell.layer.borderWidth = 0.75
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        viewModel.navigateToDetailScreen(
            id: viewModel.savedNewsList[indexPath.item].id ?? "",
            url: viewModel.savedNewsList[indexPath.item].newsUrl ?? "",
            source: viewModel.savedNewsList[indexPath.item].source ?? "",
            newsTitle: viewModel.savedNewsList[indexPath.item].title ?? "",
            urlToImage: viewModel.savedNewsList[indexPath.item].imageUrl ?? "",
            category: viewModel.savedNewsList[indexPath.item].category ?? ""
        )
    }
}

extension SavedNewsScreen: DynamicCollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        heightForPhotoAtIndexPath indexPath: IndexPath,
        cellWidth: CGFloat) -> CGFloat {
        
        let imageHeight = CGFloat(125)
        let sourceLabelHeight = sourceRequiredHeight(
            text: viewModel.savedNewsList[indexPath.row].source!, cellWidth: (cellWidth - 10)
        )

        let titleLableHeight = requiredHeight(
            text: viewModel.savedNewsList[indexPath.row].title!, cellWidth: (cellWidth - 10)
        )

        let categoryLableHeight = sourceRequiredHeight(
            text: viewModel.savedNewsList[indexPath.row].category!, cellWidth: (cellWidth - 10)
        )

        let spacing = CGFloat(35)

        return (imageHeight + sourceLabelHeight + titleLableHeight + categoryLableHeight + spacing)
    }
    
    func sourceRequiredHeight(text: String, cellWidth: CGFloat) -> CGFloat {

        let font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.semibold)
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: CGFloat.dWidth / 2 - 30, height: .greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.lineBreakMode = .byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }

    func requiredHeight(text: String, cellWidth: CGFloat) -> CGFloat {

        let font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.bold)
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: CGFloat.dWidth / 2 - 30, height: .greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.lineBreakMode = .byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }

    func calcSourceLabelHeight(text: String, cellWidth: CGFloat) -> CGFloat {

        let font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.bold)
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: CGFloat.dWidth / 2 - 30, height: .greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.lineBreakMode = .byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }
}
