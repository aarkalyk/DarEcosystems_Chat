//
//  ImageViewController.swift
//  Dar_Assignment
//
//  Created by ARKALYK AKASH on 7/23/17.
//  Copyright © 2017 ARKALYK AKASH. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    //MARK: - Properties
    lazy var imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var closeButton : UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = Constants.closeButtonSize.height/2.0
        button.clipsToBounds = true
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
        return button
    }()
    
    var message : Message?{
        didSet{
            guard let message = message, let data = message.imageData else { return }
            imageView.image = UIImage(data: data as Data)
        }
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        updateViewConstraints()
    }
    
    //MARK: - Initial setup
    func setup(){
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        setupSubviews()
    }
    
    func setupSubviews(){
        view.addSubview(imageView)
        view.addSubview(closeButton)
        view.constraintsImplementedProgrammatically()
    }
    
    //MARK: - Selector actions
    func closeButtonPressed(){
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Constraints
    override func updateViewConstraints() {
        super.updateViewConstraints()
        //ImageView constraints
        let imageTop = NSLayoutConstraint(item: imageView,
                                          attribute: .top,
                                          relatedBy: .equal,
                                          toItem: view,
                                          attribute: .top,
                                          multiplier: 1.0,
                                          constant: 0)
        let imageBottom = NSLayoutConstraint(item: imageView,
                                          attribute: .bottom,
                                          relatedBy: .equal,
                                          toItem: view,
                                          attribute: .bottom,
                                          multiplier: 1.0,
                                          constant: 0)
        let imageLeading = NSLayoutConstraint(item: imageView,
                                          attribute: .leading,
                                          relatedBy: .equal,
                                          toItem: view,
                                          attribute: .leading,
                                          multiplier: 1.0,
                                          constant: 0)
        let imageTrailing = NSLayoutConstraint(item: imageView,
                                          attribute: .trailing,
                                          relatedBy: .equal,
                                          toItem: view,
                                          attribute: .trailing,
                                          multiplier: 1.0,
                                          constant: 0)
        //CloseButton constraints
        let closeButtonTop = NSLayoutConstraint(item: closeButton,
                                                attribute: .top,
                                                relatedBy: .equal,
                                                toItem: view,
                                                attribute: .top,
                                                multiplier: 1.0,
                                                constant: 15)
        let closeButtonLeading = NSLayoutConstraint(item: closeButton,
                                                attribute: .leading,
                                                relatedBy: .equal,
                                                toItem: view,
                                                attribute: .leading,
                                                multiplier: 1.0,
                                                constant: 15)
        let closeButtonHeight = NSLayoutConstraint(item: closeButton,
                                                   attribute: .height,
                                                   relatedBy: .equal,
                                                   toItem: nil,
                                                   attribute: .notAnAttribute,
                                                   multiplier: 1.0,
                                                   constant: Constants.closeButtonSize.height)
        let closeButtonWidth = NSLayoutConstraint(item: closeButton,
                                                   attribute: .width,
                                                   relatedBy: .equal,
                                                   toItem: nil,
                                                   attribute: .notAnAttribute,
                                                   multiplier: 1.0,
                                                   constant: Constants.closeButtonSize.width)
        NSLayoutConstraint.activate([imageTop, imageBottom, imageLeading, imageTrailing,
                                     closeButtonTop, closeButtonLeading, closeButtonHeight, closeButtonWidth])
    }

}
