//
//  NewsDetailScreen.swift
//  CryptoVault-UIKit
//
//  Created by Cuma on 17/05/2023.
//

import SnapKit
import UIKit
import WebKit

protocol NewsDetailScreenDelegate: AnyObject {
    func setLoading(isLoading: Bool)
    func dataError()
    func configureVC()
    func prepareFavButton()
}

final class NewsDetailScreen: UIViewController {

    var id: String?
    var url: String?
    var source: String?
    var newsTitle: String?
    var urlToImage: String?
    
    private lazy var webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    private lazy var activityIndicator = UIActivityIndicatorView()
    
    let viewModel: NewsDetailViewModel
    
    init(id: String? = nil, url: String? = nil, source: String? = nil, newsTitle: String? = nil, urlToImage: String? = nil, viewModel: NewsDetailViewModel = NewsDetailViewModel()) {
        self.id = id
        self.url = url
        self.source = source
        self.newsTitle = newsTitle
        self.urlToImage = urlToImage
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
}

extension NewsDetailScreen: NewsDetailScreenDelegate {
    
    func setLoading(isLoading: Bool) {
        if isLoading {
            self.activityIndicator.startAnimating()
        } else {
            self.activityIndicator.stopAnimating()
        }
    }
    
    func dataError() {
        self.errorMessage(title: "Error", message: "Oops! Something went wrong, Please try again.")
    }
    
    func prepareFavButton() {
        
        let favButton = UIBarButtonItem(
            image: self.viewModel.checkFav(id: id ?? "") ? .init(systemName: "star.fill") : .init(systemName: "star"),
            style: .done, target: self, action: #selector(self.starButtonTapped))

        self.navigationItem.rightBarButtonItem = favButton
    }
    
    @objc private func starButtonTapped(_ sender: UIBarButtonItem) {
        if sender.image == .init(systemName: "star.fill") {
            sender.image = .init(systemName: "star")
        } else {
            sender.image = .init(systemName: "star.fill")
        }

        viewModel.addFavorite(id: id, url: url ?? "", source: source ?? "", newsTitle: newsTitle ?? "", imageUrl: urlToImage ?? "")
    }
    
    func configureVC() {
        
        title = source?.firstUppercased
        view.backgroundColor = UIColor(named: "BackgroundColor")
        view.addSubview(webView)
        
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        activityIndicator.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
        }
        
        let newsURL = URL(string: url ?? "")
        let newsRequest = URLRequest(url: newsURL!)
        webView.load(newsRequest)
        
        webView.snp.makeConstraints{ make in
            
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalTo(view)
            make.bottom.equalTo(view.snp.bottom)
        
        }
    }
}

extension NewsDetailScreen: WKUIDelegate {
    
    
}
