//
//  NewsDetailScreen.swift
//  CryptoVault-UIKit
//
//  Created by Cuma on 17/05/2023.
//

import UIKit
import WebKit

protocol NewsDetailScreenDelegate: AnyObject {
    func configureVC()
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
    
    func configureVC() {
        title = source
        view.backgroundColor = UIColor(named: "BackgroundColor")
        view.addSubview(webView)
        
        self.tabBarController?.tabBar.isHidden = true

        let newsURL = URL(string: url ?? "")
        let newsRequest = URLRequest(url: newsURL!)
        webView.load(newsRequest)
        
        webView.snp.makeConstraints{ make in
            
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalTo(view)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            
        }
    }
    
    
    
    
}

extension NewsDetailScreen: WKUIDelegate {
    
    
}
