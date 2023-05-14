//
//  InfoCells.swift
//  CryptoVault-UIKit
//
//  Created by Cuma on 12/05/2023.
//

import SnapKit
import UIKit

final class InfoCells: UICollectionViewCell {

    static var reuseID = "InfoCell"

    private lazy var InfoName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)
        label.textColor = .gray
        label.textAlignment = .left
        return label
    }()

    private lazy var ImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .blue
        return imageView
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
        InfoName.text = ""
        ImageView.image = UIImage(named: "")
    }

    func configureCell() {
        contentView.addSubview(InfoName)
        contentView.addSubview(ImageView)

        InfoName.translatesAutoresizingMaskIntoConstraints = false
        ImageView.translatesAutoresizingMaskIntoConstraints = false

        InfoName.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(10)
            make.leading.equalTo(contentView.snp.leading)
            make.bottom.equalTo(contentView.snp.bottom).inset(10)
        }

        ImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(10)
            make.trailing.equalTo(contentView.snp.trailing).inset(5)
            make.bottom.equalTo(contentView.snp.bottom).inset(10)
        }
    }

    func design(itemName: String) {
        
        let image = UIImage(systemName: "chevron.right")?.withRenderingMode(.alwaysOriginal)
        print(image)
        InfoName.text = itemName
        ImageView.image = image
        ImageView.tintColor = .blue

    }


}
