//
//  CryptoDetailScreen.swift
//  CryptoVault-UIKit
//
//  Created by Cuma on 14/05/2023.
//

import Kingfisher
import UIKit

protocol CryptoDetailDelegate: AnyObject {
    func setLoading(isLoading: Bool)
    func dataError()
    func configureVC()
    func createComponents()
    func prepareFavButton()
}

final class CryptoDetailScreen: UIViewController {

    var id: String
    var pageTitle: String
    var price: String
    var viewModel: CryptoDetailViewModel
    
    private lazy var horizontalRankStackView: UIStackView = {

        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.spacing = 2.0
        stackView.alignment = UIStackView.Alignment.center
        stackView.backgroundColor = .white
        stackView.clipsToBounds = true
        stackView.layer.cornerRadius = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView

    }()

    private lazy var firstVerticalStackView: UIStackView = {

        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.leading
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView

    }()
    
    private lazy var secondVerticalStackView: UIStackView = {

        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.trailing
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView

    }()

    private lazy var cryptoImage: UIImageView = {
        
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
        
    }()

    private lazy var cryptoNameLabel: UILabel = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.bold)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()

    private lazy var cryptoSymbolLabel: UILabel = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.semibold)
        label.textColor = .black.withAlphaComponent(0.8)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    private lazy var rankImage: UIImageView = {
        
        let imageView = UIImageView()
        imageView.image = .init(systemName: "flag.2.crossed.fill")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .systemYellow
        return imageView
        
    }()
    
    private lazy var rankLabel: UILabel = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 28, weight: UIFont.Weight.bold)
        label.textColor = .systemYellow
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    
    
    private lazy var currentPriceLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Current Price"
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.semibold)
        label.textColor = .gray.withAlphaComponent(0.85)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    private lazy var verticalCurrentPriceStackView: UIStackView = {

        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.spacing = 5.0
        stackView.backgroundColor = .white
        stackView.clipsToBounds = true
        stackView.layer.cornerRadius = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        return stackView

    }()
    
    private lazy var horizontalUsdStackView: UIStackView = {

        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.spacing = 2.0
        stackView.alignment = UIStackView.Alignment.center
        stackView.backgroundColor = .white
        stackView.clipsToBounds = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView

    }()
    
    private lazy var usdLabel: UILabel = {
        
        let label = UILabel()
        label.text = "USD"
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    private lazy var usdPriceLabel: UILabel = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    
    
    private lazy var horizontalEurStackView: UIStackView = {

        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.spacing = 2.0
        stackView.alignment = UIStackView.Alignment.center
        stackView.backgroundColor = .white
        stackView.clipsToBounds = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView

    }()
    
    private lazy var eurLabel: UILabel = {
        
        let label = UILabel()
        label.text = "EUR"
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    private lazy var eurPriceLabel: UILabel = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    
    
    private lazy var horizontalTryStackView: UIStackView = {

        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.spacing = 2.0
        stackView.alignment = UIStackView.Alignment.center
        stackView.backgroundColor = .white
        stackView.clipsToBounds = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView

    }()
    
    private lazy var tryLabel: UILabel = {
        
        let label = UILabel()
        label.text = "TRY"
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    private lazy var tryPriceLabel: UILabel = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    
    
    private lazy var priceChangeLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Price Change (24)"
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.semibold)
        label.textColor = .gray.withAlphaComponent(0.85)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    private lazy var verticalPriceChangeStackView: UIStackView = {

        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.spacing = 5.0
        stackView.backgroundColor = .white
        stackView.clipsToBounds = true
        stackView.layer.cornerRadius = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        return stackView

    }()
    
    private lazy var horizontalUsdChangeStackView: UIStackView = {

        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.spacing = 2.0
        stackView.alignment = UIStackView.Alignment.center
        stackView.backgroundColor = .white
        stackView.clipsToBounds = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView

    }()
    
    private lazy var usdChangeLabel: UILabel = {
        
        let label = UILabel()
        label.text = "USD"
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    private lazy var usdPriceChangeLabel: UILabel = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    


    private lazy var horizontalEurChangeStackView: UIStackView = {

        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.spacing = 2.0
        stackView.alignment = UIStackView.Alignment.center
        stackView.backgroundColor = .white
        stackView.clipsToBounds = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView

    }()
    
    private lazy var eurChangeLabel: UILabel = {
        
        let label = UILabel()
        label.text = "EUR"
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    private lazy var eurPriceChangeLabel: UILabel = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    
    private lazy var horizontalTryChangeStackView: UIStackView = {

        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.spacing = 2.0
        stackView.alignment = UIStackView.Alignment.center
        stackView.backgroundColor = .white
        stackView.clipsToBounds = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView

    }()
    
    private lazy var tryChangeLabel: UILabel = {
        
        let label = UILabel()
        label.text = "TRY"
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    private lazy var tryPriceChangeLabel: UILabel = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    
    
    private lazy var descriptionLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Description"
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.semibold)
        label.textColor = .gray.withAlphaComponent(0.85)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    private lazy var verticalDescriptionStackView: UIStackView = {

        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.spacing = 5.0
        stackView.backgroundColor = .white
        stackView.clipsToBounds = true
        stackView.layer.cornerRadius = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        return stackView

    }()
    
    private lazy var detailDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    

    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let scrollStackViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isLayoutMarginsRelativeArrangement = true
        view.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
        return view
    }()
    
    init(id: String, pageTitle: String, price: String, viewModel: CryptoDetailViewModel = CryptoDetailViewModel()) {
        self.id = id
        self.pageTitle = pageTitle
        self.price = price
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad(id: id)
    }

}

extension CryptoDetailScreen: CryptoDetailDelegate {

    func configureVC() {

        title = pageTitle
        view.backgroundColor = UIColor(named: "BackgroundColor")

        view.addSubview(horizontalRankStackView)
                        
        horizontalRankStackView.addArrangedSubview(cryptoImage)

    }

    func setLoading(isLoading: Bool) {


    }

    func dataError() {

    }

    func prepareFavButton() {

        let favButton = UIBarButtonItem(
            image: self.viewModel.checkFav() ? .init(systemName: "star.fill") : .init(systemName: "star"),
            style: .done, target: self, action: #selector(self.starButtonTapped))

        self.navigationItem.rightBarButtonItem = favButton
    }

    @objc private func starButtonTapped(_ sender: UIBarButtonItem) {
        if sender.image == .init(systemName: "star.fill") {
            sender.image = .init(systemName: "star")
        } else {
            sender.image = .init(systemName: "star.fill")
        }

        //viewModel.addFavorite()
    }

    func createComponents() {

        var imageUrl = ""

        for index in viewModel.cryptoDetailList {
            imageUrl = index.image?.large ?? ""
            cryptoNameLabel.text = index.name
            cryptoSymbolLabel.text = index.symbol?.uppercased()
            if let rank = index.marketCapRank {
                rankLabel.text = "#" + "\(rank)"
            }
            
            detailDescriptionLabel.text = index.description?.en
            
        }
        
        cryptoImage.kf.setImage(with: URL(string: imageUrl))
        
        horizontalRankStackView.addArrangedSubview(firstVerticalStackView)
        horizontalRankStackView.addArrangedSubview(secondVerticalStackView)

        let screenHeight = CGFloat.dHeight

        horizontalRankStackView.snp.makeConstraints { make in

            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalTo(view.snp.leading).offset(20)
            make.trailing.equalTo(view.snp.trailing).inset(20)
            make.height.equalTo(screenHeight * 0.14)

        }

        cryptoImage.snp.makeConstraints { make in

            make.centerY.equalTo(horizontalRankStackView.snp.centerY)
            make.leading.equalTo(horizontalRankStackView.snp.leading).offset(10)
            make.height.equalTo(70)
            make.width.equalTo(70)

        }

        firstVerticalStackView.addArrangedSubview(cryptoNameLabel)
        firstVerticalStackView.addArrangedSubview(cryptoSymbolLabel)
        
        secondVerticalStackView.addArrangedSubview(rankImage)
        secondVerticalStackView.addArrangedSubview(rankLabel)

        firstVerticalStackView.snp.makeConstraints { make in

            make.leading.equalTo(cryptoImage.snp.trailing).offset(10)
            make.centerY.equalTo(horizontalRankStackView.snp.centerY)

        }
        
        secondVerticalStackView.snp.makeConstraints { make in

            make.leading.equalTo(firstVerticalStackView.snp.trailing).offset(10)
            make.trailing.equalTo(view.snp.trailing).inset(30)
            make.centerY.equalTo(horizontalRankStackView.snp.centerY)

        }
        
        rankImage.snp.makeConstraints { make in

            make.width.equalTo(55)
            make.height.equalTo(35)
            
        }
        
        rankLabel.snp.makeConstraints { make in

            make.centerX.equalTo(secondVerticalStackView.snp.centerX)

        }
        
        verticalCurrentPriceStackView.addArrangedSubview(horizontalUsdStackView)
        verticalCurrentPriceStackView.addArrangedSubview(horizontalEurStackView)
        verticalCurrentPriceStackView.addArrangedSubview(horizontalTryStackView)
        
        usdPriceLabel.text = String(format: "%.2f", viewModel.usdPrice) + "$"
        horizontalUsdStackView.addArrangedSubview(usdLabel)
        horizontalUsdStackView.addArrangedSubview(usdPriceLabel)
        
        eurPriceLabel.text = String(format: "%.2f", viewModel.eurPrice) + "€"
        horizontalEurStackView.addArrangedSubview(eurLabel)
        horizontalEurStackView.addArrangedSubview(eurPriceLabel)
        
        horizontalEurStackView.snp.makeConstraints {make in
            
            make.top.equalTo(horizontalUsdStackView.snp.bottom).offset(10)

        }
        
        tryPriceLabel.text = String(format: "%.2f", viewModel.tryPrice) + "₺"
        horizontalTryStackView.addArrangedSubview(tryLabel)
        horizontalTryStackView.addArrangedSubview(tryPriceLabel)
        
        verticalPriceChangeStackView.addArrangedSubview(horizontalUsdChangeStackView)
        verticalPriceChangeStackView.addArrangedSubview(horizontalEurChangeStackView)
        verticalPriceChangeStackView.addArrangedSubview(horizontalTryChangeStackView)
        
        usdPriceChangeLabel.text = String(format: "%.2f", viewModel.usdPriceChange) + "%"
        
        if usdPriceChangeLabel.text?.first == "-" {
            usdPriceChangeLabel.textColor = .systemRed
        }else{
            usdPriceChangeLabel.textColor = .systemGreen
        }
        
        horizontalUsdChangeStackView.addArrangedSubview(usdChangeLabel)
        horizontalUsdChangeStackView.addArrangedSubview(usdPriceChangeLabel)
        
        eurPriceChangeLabel.text = String(format: "%.2f", viewModel.eurPriceChange) + "%"
        if eurPriceChangeLabel.text?.first == "-" {
            eurPriceChangeLabel.textColor = .systemRed
        }else{
            eurPriceChangeLabel.textColor = .systemGreen
        }
        horizontalEurChangeStackView.addArrangedSubview(eurChangeLabel)
        horizontalEurChangeStackView.addArrangedSubview(eurPriceChangeLabel)
        
        tryPriceChangeLabel.text = String(format: "%.2f", viewModel.tryPriceChange) + "%"
        if tryPriceChangeLabel.text?.first == "-" {
            tryPriceChangeLabel.textColor = .systemRed
        }else{
            tryPriceChangeLabel.textColor = .systemGreen
        }
        horizontalTryChangeStackView.addArrangedSubview(tryChangeLabel)
        horizontalTryChangeStackView.addArrangedSubview(tryPriceChangeLabel)
        
        verticalDescriptionStackView.addArrangedSubview(detailDescriptionLabel)
        
        setupScroolView()
        
    }
    
    func setupScroolView() {
        
        view.addSubview(scrollView)
        scrollView.addSubview(scrollStackViewContainer)
        scrollView.showsVerticalScrollIndicator = true
        
        let margins = view.layoutMarginsGuide

        NSLayoutConstraint.activate([

            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: margins.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
        ])
        
        /*scrollView.snp.makeConstraints { make  in
            
            make.top.equalTo(view.layoutMarginsGuide.snp.top)
            make.bottom.equalTo(view.layoutMarginsGuide.snp.bottom)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            
        }*/
        
        NSLayoutConstraint.activate([

            scrollStackViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollStackViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollStackViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollStackViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            scrollStackViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        /*scrollStackViewContainer.snp.makeConstraints {make in
            
            make.top.equalTo(scrollView.snp.top)
            make.bottom.equalTo(scrollView.snp.bottom)
            make.leading.equalTo(scrollView.snp.leading)
            make.trailing.equalTo(scrollView.snp.trailing)
            make.width.equalTo(scrollView.snp.width)
            
        }*/
        
        configureContainerView()

    }
    
    func configureContainerView() {
        
        scrollStackViewContainer.addArrangedSubview(horizontalRankStackView)
        
        scrollStackViewContainer.setCustomSpacing(25, after: horizontalRankStackView)

        scrollStackViewContainer.addArrangedSubview(currentPriceLabel)
        
        currentPriceLabel.snp.makeConstraints {make in
            make.leading.equalTo(scrollView.snp.leading).inset(30)
        }

        scrollStackViewContainer.setCustomSpacing(5, after: currentPriceLabel)

        scrollStackViewContainer.addArrangedSubview(verticalCurrentPriceStackView)
        
        scrollStackViewContainer.addArrangedSubview(priceChangeLabel)
        
        priceChangeLabel.snp.makeConstraints {make in
            make.leading.equalTo(scrollView.snp.leading).inset(30)
        }
        
        scrollStackViewContainer.setCustomSpacing(5, after: priceChangeLabel)
        
        
        scrollStackViewContainer.setCustomSpacing(20, after: verticalCurrentPriceStackView)
        scrollStackViewContainer.addArrangedSubview(verticalPriceChangeStackView)
        scrollStackViewContainer.setCustomSpacing(20, after: verticalPriceChangeStackView)

        
        scrollStackViewContainer.addArrangedSubview(descriptionLabel)

        descriptionLabel.snp.makeConstraints {make in
            make.leading.equalTo(scrollView.snp.leading).inset(30)
        }
        
        scrollStackViewContainer.setCustomSpacing(5, after: descriptionLabel)
        
        scrollStackViewContainer.addArrangedSubview(verticalDescriptionStackView)
        //scrollStackViewContainer.setCustomSpacing(20, after: verticalDescriptionStackView)
        
    }
}
