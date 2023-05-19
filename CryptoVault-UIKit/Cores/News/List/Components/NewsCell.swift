//
//  NewsCell.swift
//  CryptoVault-UIKit
//
//  Created by Cuma on 17/05/2023.
//

import Kingfisher
import UIKit

final class NewsCell: UICollectionViewCell {

    static var reuseID = "NewsCell"

    private lazy var newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var sourceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.semibold)
        label.textColor = .black.withAlphaComponent(0.8)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.bold)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label

    }()

    private lazy var categoriesLabel: UILabel = {

        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.semibold)
        label.textColor = .black.withAlphaComponent(0.8)
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
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

        newsImageView.kf.cancelDownloadTask()
    }

    func configureCell() {

        contentView.addSubview(newsImageView)
        contentView.addSubview(sourceLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(categoriesLabel)

        newsImageView.snp.makeConstraints { make in

            make.top.equalTo(contentView.snp.top)
            make.height.equalTo(125)
            make.width.equalTo(contentView.snp.width)

        }

        sourceLabel.snp.makeConstraints { make in

            make.top.equalTo(newsImageView.snp.bottom).offset(10)
            make.leading.equalTo(contentView.snp.leading).offset(5)
            make.trailing.equalTo(contentView.snp.trailing).inset(5)

        }

        titleLabel.snp.makeConstraints { make in

            make.top.equalTo(sourceLabel.snp.bottom).offset(10)
            make.leading.equalTo(contentView.snp.leading).offset(5)
            make.width.equalTo(CGFloat.dWidth / 2 - 30)
            make.trailing.equalTo(contentView.snp.trailing).inset(5)

        }

        categoriesLabel.snp.makeConstraints { make in

            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.width.equalTo(contentView.snp.width)
            make.bottom.equalTo(contentView.snp.bottom).inset(5)
            make.leading.equalTo(contentView.snp.leading).offset(5)

        }


    }

    func design(source: String, imageUrl: String, title: String, date: String) {

        let url = URL(string: imageUrl)
        newsImageView.kf.setImage(with: url)
        sourceLabel.text = source
        titleLabel.text = title
        categoriesLabel.text = date

    }
}
