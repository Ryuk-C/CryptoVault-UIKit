//
//  UIView+Ext.swift
//  CryptoVault-UIKit
//
//  Created by Cuma on 17/05/2023.
//

import UIKit

extension UIView {

    func addTapGesture(action: @escaping () -> Void) {
        let tap = MyTapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        tap.action = action
        tap.numberOfTapsRequired = 1

        self.addGestureRecognizer(tap)
        self.isUserInteractionEnabled = true

    }

    @objc func handleTap(_ sender: MyTapGestureRecognizer) {
        sender.action!()
    }
}

class MyTapGestureRecognizer: UITapGestureRecognizer {
    var action: (() -> Void)? = nil
}
