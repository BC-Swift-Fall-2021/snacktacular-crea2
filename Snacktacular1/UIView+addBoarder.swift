//
//  UIView+addBoarder.swift
//  Snacktacular1
//
//  Created by Christopher Rea on 11/14/21.
//

import UIKit

extension UIView {
    func addBorder(width: CGFloat, radius: CGFloat, color: UIColor) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
        self.layer.cornerRadius = radius
    }
    func noBorder() {
        self.layer.borderWidth = 0.0
    }
}
