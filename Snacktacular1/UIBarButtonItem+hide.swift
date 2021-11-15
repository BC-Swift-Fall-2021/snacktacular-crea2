//
//  UIBarButtonItem+hide.swift
//  Snacktacular1
//
//  Created by Christopher Rea on 11/14/21.
//

import UIKit

extension UIBarButtonItem {
    func hide() {
        self.isEnabled = false
        self.tintColor = .clear
    }
}
