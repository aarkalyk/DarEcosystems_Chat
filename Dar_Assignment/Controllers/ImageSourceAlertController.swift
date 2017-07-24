//
//  ImageSourceAlertController.swift
//  Dar_Assignment
//
//  Created by ARKALYK AKASH on 7/24/17.
//  Copyright © 2017 ARKALYK AKASH. All rights reserved.
//

import UIKit

protocol ImageSourceAlertControllerDelegate {
    func cameraSourceSelected()
    func imageLibrarySourceSelected()
}

class ImageSourceAlertController: UIAlertController {
    //MARK: - Properties
    var delegate : ImageSourceAlertControllerDelegate?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
    }
    
    //MARK: - Initial setup
    func setupActions(){
        let alertController = UIAlertController(title: Hints.imagePickerDialogString, message: nil, preferredStyle: UIAlertControllerStyle.alert)
        let DestructiveAction = UIAlertAction(title: Hints.cancelString, style: UIAlertActionStyle.destructive) { (result: UIAlertAction) in
            print("Canceled")
        }
        let cameraAction = UIAlertAction(title: Hints.cameraString, style: UIAlertActionStyle.default) {
            (result : UIAlertAction) -> Void in
            if let delegate = self.delegate{
                delegate.cameraSourceSelected()
            }
        }
        let photoLibraryAction = UIAlertAction(title: Hints.imageLibraryString, style: UIAlertActionStyle.default) {
            (result : UIAlertAction) -> Void in
            if let delegate = self.delegate{
                delegate.imageLibrarySourceSelected()
            }
        }
        self.addAction(cameraAction)
        self.addAction(photoLibraryAction)
        self.addAction(DestructiveAction)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
