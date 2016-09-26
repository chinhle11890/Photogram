//
//  EditProfileViewController.swift
//  Photogram
//
//  Created by Nguyen Bao on 9/26/16.
//  Copyright © 2016 Chinh Le. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func didClickBackButton(_ sender: AnyObject) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didClickDoneButton(_ sender: AnyObject) {
        _ = navigationController?.popViewController(animated: true)
    }
    
}
