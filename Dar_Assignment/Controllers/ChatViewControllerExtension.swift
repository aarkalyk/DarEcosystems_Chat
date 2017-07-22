//
//  ChatViewControllerExtension.swift
//  Dar_Assignment
//
//  Created by ARKALYK AKASH on 7/23/17.
//  Copyright © 2017 ARKALYK AKASH. All rights reserved.
//

import Foundation
import UIKit

//MARK: - TableView delegate and datasource
extension ChatViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 30))
        label.backgroundColor = .customLightGray
        label.font = .helveticaNeueLight(size: 12)
        label.textAlignment = .center
        label.text = days[section]
        return label
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return days[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return messageDateDictionary.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let day = days[section]
        guard let count = messageDateDictionary[day]?.count else {
            return 0
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let day = days[indexPath.section]
        let message = messageDateDictionary[day]?[indexPath.row]
        
        if (message?.imageData) != nil {
            let cell = tableView.dequeueReusableCell(withIdentifier: Hints.imageTableViewCellIdentifier, for: indexPath) as! ChatBubbleImageTableViewCell
            cell.message = message
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: Hints.textTableViewCellIdentifier, for: indexPath) as! ChatBubbleTextTableViewCell
            cell.message = message
            return cell
        }
    }
}

//MARK: - ChatInputView delegate
extension ChatViewController: ChatInputViewDelegate{
    func didHitSendButtonWith(text: String) {
        let message = Message(text: text, imageData: nil, context: context)
        addMessageToDictionary(message: message)
        tableView.reloadData()
        dismissKeyboard()
        saveContext()
    }
    
    func didHitAttachButton() {
        showImagePickerController()
    }
}

//MARK: - UIImagePickerController
extension ChatViewController: UIImagePickerControllerDelegate{
    func showImagePickerController(){
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[Hints.imageDataKey] as! UIImage
        if let data = UIImagePNGRepresentation(image) as NSData?{
            let message = Message(text: nil, imageData: data, context: context)
            print("\n\n message \(message) \n\n")
            addMessageToDictionary(message: message)
            tableView.reloadData()
            scrollToLatestMessage()
            saveContext()
        }
        picker.dismiss(animated: true, completion: nil)
    }
}

extension ChatViewController{
    //MARK: - CoreData
    func getData(){
        do{
            messages = try context.fetch(Message.fetchRequest())
        }catch{
            print("error when fetching data")
        }
        saveMessagesInDictionary()
    }
    
    func saveMessagesInDictionary(){
        for message in messages {
            addMessageToDictionary(message: message)
        }
        tableView.reloadData()
        scrollToLatestMessage()
    }
    
    func addMessageToDictionary(message : Message){
        let dateString = NSDate.dateStringFrom(date: message.createdAt!)
        if messageDateDictionary[dateString] == nil {
            messageDateDictionary[dateString] = []
        }
        messageDateDictionary[dateString]?.append(message)
        if !days.contains(dateString) {
            days.append(dateString)
        }
    }
    
    func saveContext(){
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
    //MARK: - Notification actions
    func keyBoardWillShow(notification: Notification){
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            moveInpuViewUpwards(byValue: keyboardHeight)
        }
    }
    
    func keyBoardWillHide(notification: Notification){
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            moveInpuViewDownwards(byValue: keyboardHeight)
        }
    }
    
    //MARK: - Helper methods
    func moveInpuViewUpwards(byValue : CGFloat){
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: byValue+15, right: 0)
        scrollToLatestMessage()
        UIView.animate(withDuration: 0.3) {
            self.chatInputView.frame.origin.y -= byValue
        }
    }
    
    func moveInpuViewDownwards(byValue : CGFloat){
        tableView.contentInset = Hints.tableViewRegularInsets
        scrollToLatestMessage()
        UIView.animate(withDuration: 0.3) {
            self.chatInputView.frame.origin.y += byValue
            self.updateViewConstraints()
        }
    }
    
    func scrollToLatestMessage(){
        guard days.count > 0 else{
            return
        }
        let day = days[days.count-1]
        guard let todaysMessages = messageDateDictionary[day] else {
            return
        }
        let row = todaysMessages.count - 1
        let indexPath = IndexPath(row: row, section: days.count-1)
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
    
    //MARK: - Selector actions
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        tableView.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
