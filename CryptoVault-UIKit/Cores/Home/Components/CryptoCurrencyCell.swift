//
//  CryptoCurrencyCell.swift
//  CryptoVault-UIKit
//
//  Created by Cuma on 14/05/2023.
//

import Kingfisher
import UIKit

final class CryptoCurrencyCell: UICollectionViewCell {
    
    static var reuseID = "CryptoCurrencyCell"
    
    private lazy var cryptoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var cryptoNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private lazy var cryptoSymbolLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private lazy var cryptoPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private lazy var cryptoPriceChangesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        cryptoImageView.kf.cancelDownloadTask()
    }
    
    func configureCell() {
        
        contentView.addSubview(cryptoImageView)
        contentView.addSubview(cryptoNameLabel)
        contentView.addSubview(cryptoSymbolLabel)
        contentView.addSubview(cryptoPriceLabel)
        contentView.addSubview(cryptoPriceChangesLabel)
        
        cryptoImageView.translatesAutoresizingMaskIntoConstraints = false
        cryptoNameLabel.translatesAutoresizingMaskIntoConstraints = false
        cryptoSymbolLabel.translatesAutoresizingMaskIntoConstraints = false
        cryptoPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        cryptoPriceChangesLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let imageHeight = CGFloat.dHeight * 0.5

        cryptoImageView.snp.makeConstraints{ make in
            
            make.top.equalTo(contentView.snp.top)
            make.leading.equalTo(contentView.snp.leading).offset(10)
            make.centerY.equalTo(contentView.snp.centerY)
            make.height.equalTo(50)
            make.width.equalTo(50)

        }
        
        cryptoNameLabel.snp.makeConstraints{make in
            
            make.leading.equalTo(cryptoImageView.snp.trailing)
            
        }
        
    }
    
    func design(imageUrl: String, name: String) {
        
        let url = URL(string: imageUrl)
        cryptoImageView.kf.setImage(with: url)
        cryptoNameLabel.text = name
    }
}
