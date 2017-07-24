//
//  ChatTextField.swift
//  Dar_Assignment
//
//  Created by ARKALYK AKASH on 7/23/17.
//  Copyright © 2017 ARKALYK AKASH. All rights reserved.
//

import UIKit

class ChatTextField: UITextField {
    //MARK: - Properties
    let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 5.0
        self.clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Content insets
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }

}
