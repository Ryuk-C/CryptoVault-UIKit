//
//  CryptoDetailScreen.swift
//  CryptoVault-UIKit
//
//  Created by Cuma on 14/05/2023.
//

import UIKit

protocol CryptoDetailDelegate: AnyObject {
    func setLoading(isLoading: Bool)
    func dataError()
    func configureVC()
}

final class CryptoDetailScreen: UIViewController {

    var id : String
    var pageTitle : String
    var price : String
    var viewModel : CryptoDetailViewModel
    
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
        print("-------")
        print(id)
        viewModel.viewDidLoad(id: id)

    }

}

extension CryptoDetailScreen: CryptoDetailDelegate {
    
    func configureVC() {
        
        title = pageTitle
        view.backgroundColor = UIColor(named: "BackgroundColor")

    }
    
    func setLoading(isLoading: Bool) {
        
        
    }
    
    func dataError() {
        
    }
    
}
