//
//  ChatViewController.swift
//  Dar_HW
//
//  Created by ARKALYK AKASH on 7/20/17.
//  Copyright © 2017 ARKALYK AKASH. All rights reserved.
//

import CoreData
import UIKit

class ChatViewController: UIViewController, UINavigationControllerDelegate {
    //MARK: - Properties
    lazy var tableView : UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.clipsToBounds = true
        tableView.separatorColor = .clear
        tableView.backgroundColor = .clear
        tableView.contentInset = Hints.tableViewRegularInsets
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        tableView.register(ChatBubbleImageTableViewCell.self, forCellReuseIdentifier: Hints.imageTableViewCellIdentifier)
        tableView.register(ChatBubbleTextTableViewCell.self, forCellReuseIdentifier: Hints.textTableViewCellIdentifier)
        return tableView
    }()
    
    lazy var chatInputView : ChatInputView = {
        let inputView = ChatInputView()
        inputView.delegate = self
        return inputView
    }()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var messages : [Message] = []
    var days : [String] = []
    var messageDateDictionary : [String : [Message]] = [:]
    
    lazy var imagePicker : UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = false
        return imagePicker
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        updateViewConstraints()
        getData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        scrollToLatestMessage()
    }
    
    //MARK: - Initial setup
    func setup(){
        self.title = Hints.chatViewControllerTitle
        hideKeyboardWhenTappedAround()
        setupSubviews()
        setupNotifications()
    }
    
    func setupSubviews(){
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(chatInputView)
        for subView in view.subviews {
            subView.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func setupNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    //MARK: - Constraints
    override func updateViewConstraints() {
        super.updateViewConstraints()
        //TableView constraints
        let tableViewTop = NSLayoutConstraint(item: tableView,
                                              attribute: .top,
                                              relatedBy: .equal,
                                              toItem: self.view,
                                              attribute: .top,
                                              multiplier: 1.0,
                                              constant: 0)
        let tableViewBottom = NSLayoutConstraint(item: tableView,
                                                 attribute: .bottom,
                                                 relatedBy: .equal,
                                                 toItem: self.view,
                                                 attribute: .bottom,
                                                 multiplier: 1.0,
                                                 constant: -44)
        let tableViewLeading = NSLayoutConstraint(item: tableView,
                                                  attribute: .leading,
                                                  relatedBy: .equal,
                                                  toItem: self.view,
                                                  attribute: .leading,
                                                  multiplier: 1.0,
                                                  constant: 0)
        let tableViewTrailing = NSLayoutConstraint(item: tableView,
                                                   attribute: .trailing,
                                                   relatedBy: .equal,
                                                   toItem: self.view,
                                                   attribute: .trailing,
                                                   multiplier: 1.0,
                                                   constant: 0)
        //ChatInputView constraints
        let inputViewTop = NSLayoutConstraint(item: chatInputView,
                                              attribute: .top,
                                              relatedBy: .equal,
                                              toItem: tableView,
                                              attribute: .bottom,
                                              multiplier: 1.0,
                                              constant: 0)
        let inputViewBottom = NSLayoutConstraint(item: chatInputView,
                                                 attribute: .bottom,
                                                 relatedBy: .equal,
                                                 toItem: view,
                                                 attribute: .bottom,
                                                 multiplier: 1.0,
                                                 constant: 0)
        let inputViewLeading = NSLayoutConstraint(item: chatInputView,
                                                  attribute: .leading,
                                                  relatedBy: .equal,
                                                  toItem: view,
                                                  attribute: .leading,
                                                  multiplier: 1.0,
                                                  constant: 0)
        let inputViewTrailing = NSLayoutConstraint(item: chatInputView,
                                                   attribute: .trailing,
                                                   relatedBy: .equal,
                                                   toItem: view,
                                                   attribute: .trailing,
                                                   multiplier: 1.0,
                                                   constant: 0)
        
        NSLayoutConstraint.activate([tableViewTop, tableViewBottom, tableViewLeading, tableViewTrailing,
                                     inputViewTop, inputViewBottom, inputViewLeading, inputViewTrailing])
    }
}
