//
//  UIImageViewExtension.swift
//  Dar_Assignment
//
//  Created by ARKALYK AKASH on 7/22/17.
//  Copyright © 2017 ARKALYK AKASH. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func setColor(color: UIColor) {
        self.image = self.image?.withRenderingMode(.alwaysTemplate)
        self.tintColor = color
    }
}
