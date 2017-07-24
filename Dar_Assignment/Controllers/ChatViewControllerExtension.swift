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
        let message = messageAt(indexPath: indexPath)
        if (message.imageData) != nil {
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.imageTableViewCellIdentifier, for: indexPath) as! ChatBubbleImageTableViewCell
            cell.message = message
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.textTableViewCellIdentifier, for: indexPath) as! ChatBubbleTextTableViewCell
            cell.message = message
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let message = messageAt(indexPath: indexPath)
        if (message.imageData) != nil {
            let vc = ImageViewController()
            vc.message = message
            //self.present(vc, animated: true, completion: nil)
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        dismissKeyboard()
    }
}

//MARK: - ChatInputView delegate
extension ChatViewController: ChatInputViewDelegate{
    func didHitSendButtonWith(text: String) {
        let message = Message(text: text, imageData: nil, context: context)
        sendNewMessage(message: message)
    }
    
    func didHitAttachButton() {
        showImagePickerAlert()
    }
}

//MARK: - UIImagePickerController
extension ChatViewController: UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[Hints.imageDataKey] as! UIImage
        if let data = UIImagePNGRepresentation(image) as NSData?{
            let message = Message(text: nil, imageData: data, context: context)
            sendNewMessage(message: message)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func showImagePickerAlert(){
        self.present(imageSourceAlertController, animated: true, completion: nil)
    }
}

extension ChatViewController: ImageSourceAlertControllerDelegate{
    func cameraSourceSelected() {
        imagePicker.sourceType = .camera
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imageLibrarySourceSelected() {
        imagePicker.sourceType = .savedPhotosAlbum
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
}

extension ChatViewController{
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
        var newInsets = Constants.tableViewRegularInsets
        newInsets.bottom += byValue+15
        tableView.contentInset = newInsets
        scrollToLatestMessage()
        UIView.animate(withDuration: 0.3) {
            self.chatInputView.frame.origin.y -= byValue
        }
    }
    
    func moveInpuViewDownwards(byValue : CGFloat){
        tableView.contentInset = Constants.tableViewRegularInsets
        UIView.animate(withDuration: 0.3) {
            self.chatInputView.frame.origin.y += byValue
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
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
    }
    
    func sendNewMessage(message : Message){
        addMessageToDictionary(message: message)
        tableView.reloadData()
        dismissKeyboard()
        DispatchQueue.main.async {
            self.scrollToLatestMessage()
        }
        saveContext()
    }
    
    func messageAt(indexPath : IndexPath) -> Message{
        let day = days[indexPath.section]
        let message = messageDateDictionary[day]?[indexPath.row]
        return message!
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
