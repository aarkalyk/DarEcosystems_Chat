//
//  UIViewExtension.swift
//  Dar_Assignment
//
//  Created by ARKALYK AKASH on 7/23/17.
//  Copyright © 2017 ARKALYK AKASH. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    func constraintsImplementedProgrammatically(){
        for subview in subviews{
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}
