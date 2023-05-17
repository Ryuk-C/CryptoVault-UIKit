//
//  ReusableLabel.swift
//  CryptoVault-UIKit
//
//  Created by Cuma on 17/05/2023.
//

import UIKit

class ReusableLabel: UILabel {
    
    enum labelTypeEnum {
        case H1
        case H2
        case H3
    }
    
    enum colorStyle {
        case black
        case grey1
        case grey2
        case grey3
        case white
    }
    
    public private(set) var labelType: labelTypeEnum
    public private(set) var labelText: String
    public private(set) var labelColor: colorStyle
    
    init(labelText: String, labelType: labelTypeEnum, labelColor: colorStyle) {
        self.labelText = labelText
        self.labelType = labelType
        self.labelColor = labelColor
        
        super.init(frame: .zero)
        self.configureLabelStyle()
        self.configureLabelColor()
        
        self.translatesAutoresizingMaskIntoConstraints = false //For AutoLayout
        let attributedString = NSMutableAttributedString(string: labelText)
        self.attributedText = attributedString //Setup Label to AttributedString for custom font
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLabelColor() {
        switch labelColor {
        case .black:
            self.textColor = UIColor(named: "black")
        case .grey1:
            self.textColor = UIColor(named: "grey1")
        case .grey2:
            self.textColor = UIColor(named: "grey2")
        case .grey3:
            self.textColor = UIColor(named: "grey3")
        case .white:
            self.textColor = UIColor(named: "white")
        }
    }
    
    private func configureLabelStyle() {
        switch labelType {
        case .H1:
            self.font = UIFont(name: "Poppins-Bold", size: 24)
        case .H2:
            self.font = UIFont(name: "Poppins-Bold", size: 16)
        case .H3:
            self.font = UIFont(name: "Poppins-Bold", size: 12)
            
        }
    }
}
