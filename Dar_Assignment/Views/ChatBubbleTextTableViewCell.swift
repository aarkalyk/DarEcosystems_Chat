//
//  ChatBubbleTextTableViewCell.swift
//  Dar_Assignment
//
//  Created by ARKALYK AKASH on 7/23/17.
//  Copyright © 2017 ARKALYK AKASH. All rights reserved.
//

import UIKit

class ChatBubbleTextTableViewCell: UITableViewCell {
    //MARK: - Properties
    lazy var bubbleView : UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 5.0
        view.backgroundColor = .customLightBlue
        return view
    }()
    
    lazy var contentLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.backgroundColor = .clear
        label.font = .helveticaNeueLight(size: 17)
        return label
    }()
    
    lazy var dateLabel : UILabel = {
        let label = UILabel()
        label.text = "Date"
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
            contentLabel.text = message.text
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
        self.contentView.addSubview(bubbleView)
        self.contentView.addSubview(contentLabel)
        self.contentView.addSubview(dateLabel)
        contentView.constraintsImplementedProgrammatically()
    }
    
    //MARK: - Constraints
    override func updateConstraints() {
        super.updateConstraints()
        //ContentLabel constraints
        let labelTop = NSLayoutConstraint(item: contentLabel,
                                          attribute: .top,
                                          relatedBy: .equal,
                                          toItem: self.contentView,
                                          attribute: .topMargin,
                                          multiplier: 1,
                                          constant: 0)
        let labelBottom = NSLayoutConstraint(item: contentLabel,
                                             attribute: .bottom,
                                             relatedBy: .equal,
                                             toItem: self.contentView,
                                             attribute: .bottomMargin,
                                             multiplier: 1,
                                             constant: -15)
        let labelLeading = NSLayoutConstraint(item: contentLabel,
                                              attribute: .leading,
                                              relatedBy: .greaterThanOrEqual,
                                              toItem: self.contentView,
                                              attribute: .leadingMargin,
                                              multiplier: 1,
                                              constant: 40)
        let labelTrailing = NSLayoutConstraint(item: contentLabel,
                                               attribute: .trailing,
                                               relatedBy: .equal,
                                               toItem: self.contentView,
                                               attribute: .trailingMargin,
                                               multiplier: 1,
                                               constant: -8)
        //DateLabel constraints
        let dateTop = NSLayoutConstraint(item: dateLabel,
                                         attribute: .top,
                                         relatedBy: .equal,
                                         toItem: self.contentLabel,
                                         attribute: .bottomMargin,
                                         multiplier: 1,
                                         constant: 10)
        let dateLeft = NSLayoutConstraint(item: dateLabel,
                                          attribute: .leading,
                                          relatedBy: .equal,
                                          toItem: contentLabel,
                                          attribute: .leadingMargin,
                                          multiplier: 1,
                                          constant: 0)
        let dateRight = NSLayoutConstraint(item: dateLabel,
                                           attribute: .trailing,
                                           relatedBy: .equal,
                                           toItem: contentLabel,
                                           attribute: .trailing,
                                           multiplier: 1,
                                           constant: -5)
        let dateBottom = NSLayoutConstraint(item: dateLabel,
                                            attribute: .bottom,
                                            relatedBy: .equal,
                                            toItem: self.contentView,
                                            attribute: .bottom,
                                            multiplier: 1,
                                            constant: -10)
        //BubbleView constraints
        let bubbleTop = NSLayoutConstraint(item: bubbleView,
                                           attribute: .top,
                                           relatedBy: .equal,
                                           toItem: contentLabel,
                                           attribute: .top,
                                           multiplier: 1.0,
                                           constant: -5)
        let bubbleBottom = NSLayoutConstraint(item: bubbleView,
                                              attribute: .bottom,
                                              relatedBy: .equal,
                                              toItem: dateLabel,
                                              attribute: .bottom,
                                              multiplier: 1.0,
                                              constant: 5)
        let bubbleLeading = NSLayoutConstraint(item: bubbleView,
                                               attribute: .leading,
                                               relatedBy: .equal,
                                               toItem: contentLabel,
                                               attribute: .leading,
                                               multiplier: 1.0,
                                               constant: -5)
        let bubbleTrailing = NSLayoutConstraint(item: bubbleView,
                                                attribute: .trailing,
                                                relatedBy: .equal,
                                                toItem: contentLabel,
                                                attribute: .trailing,
                                                multiplier: 1.0,
                                                constant: 5)
        
        NSLayoutConstraint.activate([labelTop, labelBottom, labelLeading, labelTrailing,
                                     dateTop, dateLeft, dateRight, dateBottom,
                                     bubbleTop, bubbleBottom, bubbleLeading, bubbleTrailing])
    }
}
