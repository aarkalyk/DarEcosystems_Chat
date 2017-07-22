//
//  UIFontExtension.swift
//  Dar_HW
//
//  Created by ARKALYK AKASH on 7/22/17.
//  Copyright © 2017 ARKALYK AKASH. All rights reserved.
//

import Foundation
import UIKit

extension UIFont{
    static func helveticaNeueRegular(size : CGFloat) -> UIFont{
        guard let font = UIFont(name: FontNames.helveticaNeue, size: size) else {
            return UIFont()
        }
        return font
    }
    
    static func helveticaNeueLight(size : CGFloat) -> UIFont{
        guard let font = UIFont(name: FontNames.helveticaNeueLight, size: size) else {
            return UIFont()
        }
        return font
    }
}
