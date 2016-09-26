//
//  SignupViewController.swift
//  Photogram
//
//  Created by Chinh Le on 9/19/16.
//  Copyright © 2016 Chinh Le. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {
    @IBOutlet weak var signupButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signupButton?.backgroundColor = UIColor.white
        signupButton?.layer.cornerRadius = 15
        signupButton?.clipsToBounds = true

        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(SignupViewController.handleTap))
        self.view.addGestureRecognizer(tapRecognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Actions
    func handleTap() {
        self.view.endEditing(true)
    }
    
    @IBAction func dismissButtonAction(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func photographerButtonAction(sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
}
