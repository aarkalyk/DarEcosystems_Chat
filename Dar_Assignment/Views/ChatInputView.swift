//
//  ChatInputView.swift
//  Dar_HW
//
//  Created by ARKALYK AKASH on 7/22/17.
//  Copyright © 2017 ARKALYK AKASH. All rights reserved.
//

import UIKit

protocol ChatInputViewDelegate : AnyObject {
    func didHitSendButtonWith(text : String)
    func didHitAttachButton()
}

class ChatInputView: UIView {
    
    //MARK: - Properties
    weak var delegate : ChatInputViewDelegate?
    
    lazy var attachButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setImage(#imageLiteral(resourceName: "clipGray"), for: .normal)
        button.addTarget(self, action: #selector(attachButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var sendButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "paperPlaneGray"), for: .disabled)
        button.setImage(#imageLiteral(resourceName: "paperPlaneBlue"), for: .normal)
        button.isEnabled = false
        button.addTarget(self, action: #selector(sendButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var textField : ChatTextField = {
        let textField = ChatTextField()
        textField.backgroundColor = .white
        textField.delegate = self
        textField.placeholder = Hints.textFieldPlaceHolder
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return textField
    }()
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        updateConstraints()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Initial setup
    func setup(){
        self.backgroundColor = .customLightGray
        setupSubviews()
    }
    
    func setupSubviews(){
        self.addSubview(attachButton)
        self.addSubview(textField)
        self.addSubview(sendButton)
        self.constraintsImplementedProgrammatically()
    }
    
    //MARK: - Selector actions
    func sendButtonPressed(){
        guard let delegate = delegate else {
            return
        }
        delegate.didHitSendButtonWith(text: textField.text!)
        sendButton.isEnabled = false
        textField.text = ""
    }
    
    func attachButtonPressed(){
        guard let delegate = delegate else {
            return
        }
        delegate.didHitAttachButton()
    }
    
    //MARK: - Constraints
    override func updateConstraints() {
        super.updateConstraints()
        //TextField constraints
        let textFieldTop = NSLayoutConstraint(item: textField,
                                              attribute: .top,
                                              relatedBy: .equal,
                                              toItem: self,
                                              attribute: .top,
                                              multiplier: 1.0,
                                              constant: 5)
        let textFieldBottom = NSLayoutConstraint(item: textField,
                                                 attribute: .bottom,
                                                 relatedBy: .equal,
                                                 toItem: self,
                                                 attribute: .bottom,
                                                 multiplier: 1.0,
                                                 constant: -5)
        let textFieldLeading = NSLayoutConstraint(item: textField,
                                                  attribute: .leading,
                                                  relatedBy: .equal,
                                                  toItem: self,
                                                  attribute: .leading,
                                                  multiplier: 1.0,
                                                  constant: 49)
        let textFieldTrailing = NSLayoutConstraint(item: textField,
                                                   attribute: .trailing,
                                                   relatedBy: .equal,
                                                   toItem: self,
                                                   attribute: .trailing,
                                                   multiplier: 1.0,
                                                   constant: -49)
        //AttachButton constraints
        let attachButtonTop = NSLayoutConstraint(item: attachButton,
                                                 attribute: .top,
                                                 relatedBy: .equal,
                                                 toItem: self,
                                                 attribute: .top,
                                                 multiplier: 1.0,
                                                 constant: 0)
        let attachButtonBottom = NSLayoutConstraint(item: attachButton,
                                                    attribute: .bottom,
                                                    relatedBy: .equal,
                                                    toItem: self,
                                                    attribute: .bottom,
                                                    multiplier: 1.0,
                                                    constant: 0)
        let attachButtonLeading = NSLayoutConstraint(item: attachButton,
                                                     attribute: .leading,
                                                     relatedBy: .equal,
                                                     toItem: self,
                                                     attribute: .leading,
                                                     multiplier: 1.0,
                                                     constant: 0)
        let attachButtonTrailing = NSLayoutConstraint(item: attachButton,
                                                      attribute: .trailing,
                                                      relatedBy: .equal,
                                                      toItem: textField,
                                                      attribute: .leading,
                                                      multiplier: 1.0,
                                                      constant: -5)
        //SendButton constraints
        let sendButtonTop = NSLayoutConstraint(item: sendButton,
                                               attribute: .top,
                                               relatedBy: .equal,
                                               toItem: self,
                                               attribute: .top,
                                               multiplier: 1.0,
                                               constant: 0)
        let sendButtonBottom = NSLayoutConstraint(item: sendButton,
                                                  attribute: .bottom,
                                                  relatedBy: .equal,
                                                  toItem: self,
                                                  attribute: .bottom,
                                                  multiplier: 1.0,
                                                  constant: 0)
        let sendButtonLeading = NSLayoutConstraint(item: sendButton,
                                                   attribute: .leading,
                                                   relatedBy: .equal,
                                                   toItem: textField,
                                                   attribute: .trailing,
                                                   multiplier: 1.0,
                                                   constant: 0)
        let sendButtonTrailing = NSLayoutConstraint(item: sendButton,
                                                    attribute: .trailing,
                                                    relatedBy: .equal,
                                                    toItem: self,
                                                    attribute: .trailing,
                                                    multiplier: 1.0,
                                                    constant: 0)
        
        NSLayoutConstraint.activate([textFieldTop, textFieldBottom, textFieldLeading, textFieldTrailing,
                                     attachButtonTop, attachButtonBottom, attachButtonLeading, attachButtonTrailing,
                                     sendButtonTop, sendButtonBottom, sendButtonLeading, sendButtonTrailing])
        
    }
}

//MARK: - UITextField
extension ChatInputView: UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        sendButton.isEnabled = textField.text == "" ? false : true
    }
    
    func textFieldDidChange(_ textField : UITextField){
        sendButton.isEnabled = textField.text == "" ? false : true
    }
}









