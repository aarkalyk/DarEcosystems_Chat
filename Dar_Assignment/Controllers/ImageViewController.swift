//
//  ImageViewController.swift
//  Dar_Assignment
//
//  Created by ARKALYK AKASH on 7/23/17.
//  Copyright © 2017 ARKALYK AKASH. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    lazy var imageView : UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    lazy var closeButton : UIButton = {
        let button = UIButton()
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
