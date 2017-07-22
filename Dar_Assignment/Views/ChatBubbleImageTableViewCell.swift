//
//  ChatBubbleImageTableViewCell.swift
//  Dar_Assignment
//
//  Created by ARKALYK AKASH on 7/22/17.
//  Copyright © 2017 ARKALYK AKASH. All rights reserved.
//

import UIKit

class ChatBubbleImageTableViewCell: UITableViewCell {
    //MARK: - Properties
    lazy var bubbleView : UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 5.0
        view.backgroundColor = .customLightBlue
        return view
    }()
    
    lazy var messageImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 5.0
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var dateLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.backgroundColor = .clear
        label.font = .helveticaNeueLight(size: 12)
        return label
    }()
    
    var message : Message?{
        didSet{
            guard let message = message else {
                return
            }
            let data = message.imageData as! Data
            let image = UIImage(data: data)
            messageImageView.image = image
            dateLabel.text = NSDate.timeStringFrom(date: message.createdAt!)
        }
    }
    
    //MARK: - Initializers
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        updateConstraints()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Initial setup
    func setup(){
        self.selectionStyle = .none
        setupSubviews()
    }
    
    func setupSubviews(){
        contentView.addSubview(bubbleView)
        contentView.addSubview(messageImageView)
        contentView.addSubview(dateLabel)
        contentView.constraintsImplementedProgrammatically()
    }
    
    //MARK: - Constraints
    override func updateConstraints() {
        super.updateConstraints()
        //Image constraints
        let imageTop = NSLayoutConstraint(item: messageImageView,
                                          attribute: .top,
                                          relatedBy: .equal,
                                          toItem: contentView,
                                          attribute: .topMargin,
                                          multiplier: 1.0,
                                          constant: 20)
        let imageBottom = NSLayoutConstraint(item: messageImageView,
                                          attribute: .bottom,
                                          relatedBy: .equal,
                                          toItem: contentView,
                                          attribute: .bottomMargin,
                                          multiplier: 1.0,
                                          constant: -20)
        let imageLeading = NSLayoutConstraint(item: messageImageView,
                                          attribute: .leading,
                                          relatedBy: .greaterThanOrEqual,
                                          toItem: contentView,
                                          attribute: .leadingMargin,
                                          multiplier: 1.0,
                                          constant: 40)
        let imageTrailing = NSLayoutConstraint(item: messageImageView,
                                          attribute: .trailing,
                                          relatedBy: .equal,
                                          toItem: contentView,
                                          attribute: .trailingMargin,
                                          multiplier: 1.0,
                                          constant: -8)
        //DateLabel constraints
        let dateTop = NSLayoutConstraint(item: dateLabel,
                                         attribute: .top,
                                         relatedBy: .equal,
                                         toItem: messageImageView,
                                         attribute: .bottom,
                                         multiplier: 1.0,
                                         constant: 5)
        let dateBottom = NSLayoutConstraint(item: dateLabel,
                                         attribute: .bottom,
                                         relatedBy: .equal,
                                         toItem: contentView,
                                         attribute: .bottom,
                                         multiplier: 1.0,
                                         constant: -10)
        let dateLeading = NSLayoutConstraint(item: dateLabel,
                                         attribute: .leading,
                                         relatedBy: .equal,
                                         toItem: messageImageView,
                                         attribute: .leading,
                                         multiplier: 1.0,
                                         constant: 0)
        let dateTrailing = NSLayoutConstraint(item: dateLabel,
                                         attribute: .trailing,
                                         relatedBy: .equal,
                                         toItem: messageImageView,
                                         attribute: .trailing,
                                         multiplier: 1.0,
                                         constant: 0)
        //BubbleView constraints
        let bubbleTop = NSLayoutConstraint(item: bubbleView,
                                           attribute: .top,
                                           relatedBy: .equal,
                                           toItem: messageImageView,
                                           attribute: .top,
                                           multiplier: 1.0,
                                           constant: -10)
        let bubbleBottom = NSLayoutConstraint(item: bubbleView,
                                           attribute: .bottom,
                                           relatedBy: .equal,
                                           toItem: dateLabel,
                                           attribute: .bottom,
                                           multiplier: 1.0,
                                           constant: 10)
        let bubbleLeading = NSLayoutConstraint(item: bubbleView,
                                           attribute: .leading,
                                           relatedBy: .equal,
                                           toItem: messageImageView,
                                           attribute: .leading,
                                           multiplier: 1.0,
                                           constant: -10)
        let bubbleTrailing = NSLayoutConstraint(item: bubbleView,
                                           attribute: .trailing,
                                           relatedBy: .equal,
                                           toItem: messageImageView,
                                           attribute: .trailing,
                                           multiplier: 1.0,
                                           constant: 10)
        
        NSLayoutConstraint.activate([imageTop, imageBottom, imageLeading, imageTrailing,
                                     dateTop, dateBottom, dateLeading, dateTrailing,
                                     bubbleTop, bubbleBottom, bubbleLeading, bubbleTrailing])
    }
}
