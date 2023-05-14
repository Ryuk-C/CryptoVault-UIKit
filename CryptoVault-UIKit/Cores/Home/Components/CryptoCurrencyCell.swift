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
    
    private lazy var firstStackView: UIStackView = {
        
        let stackView   = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.equalCentering
        stackView.alignment = UIStackView.Alignment.fill
        stackView.spacing   = 2.0
        stackView.alignment = UIStackView.Alignment.leading
        return stackView
        
    }()
    
    private lazy var cryptoNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.semibold)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private lazy var cryptoSymbolLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.semibold)
        label.textColor = .black.withAlphaComponent(0.6)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var secondStackView: UIStackView = {
        
        let stackView   = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.equalCentering
        stackView.alignment = UIStackView.Alignment.fill
        stackView.spacing   = 2.0
        stackView.alignment = UIStackView.Alignment.trailing
        return stackView
        
    }()
    
    private lazy var cryptoPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.semibold)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private lazy var cryptoPriceChangesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.semibold)
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
        contentView.addSubview(firstStackView)
        contentView.addSubview(secondStackView)

        cryptoImageView.translatesAutoresizingMaskIntoConstraints = false
        cryptoNameLabel.translatesAutoresizingMaskIntoConstraints = false
        cryptoSymbolLabel.translatesAutoresizingMaskIntoConstraints = false
        cryptoPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        cryptoPriceChangesLabel.translatesAutoresizingMaskIntoConstraints = false
        firstStackView.translatesAutoresizingMaskIntoConstraints = false
        secondStackView.translatesAutoresizingMaskIntoConstraints = false

        cryptoImageView.snp.makeConstraints{ make in
            
            make.top.equalTo(contentView.snp.top)
            make.leading.equalTo(contentView.snp.leading).offset(10)
            make.centerY.equalTo(contentView.snp.centerY)
            make.height.equalTo(45)
            make.width.equalTo(45)

        }
        
        firstStackView.addArrangedSubview(cryptoNameLabel)
        firstStackView.addArrangedSubview(cryptoSymbolLabel)

        firstStackView.snp.makeConstraints{ make in
            make.leading.equalTo(cryptoImageView.snp.trailing).offset(5)
            make.centerY.equalTo(contentView.snp.centerY)
        }
        
        secondStackView.addArrangedSubview(cryptoPriceLabel)
        secondStackView.addArrangedSubview(cryptoPriceChangesLabel)

        secondStackView.snp.makeConstraints{ make in
            make.trailing.equalTo(contentView.snp.trailing).inset(10)
            make.centerY.equalTo(contentView.snp.centerY)
        }
        
    }
    
    func design(imageUrl: String, name: String, symbol: String, price: String, changes: String) {
        
        let url = URL(string: imageUrl)
        cryptoImageView.kf.setImage(with: url)
        cryptoNameLabel.text = name
        cryptoSymbolLabel.text = symbol.uppercased()
        cryptoPriceLabel.text = price + "$"
        cryptoPriceChangesLabel.text = changes + "%"
        
        if changes.first == "-"{
            cryptoPriceChangesLabel.textColor = .red
        }else{
            cryptoPriceChangesLabel.textColor = .green
        }
    }
}
