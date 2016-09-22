//
//  ForgotPasswordViewController.swift
//  Photogram
//
//  Created by Chinh Le on 9/19/16.
//  Copyright © 2016 Chinh Le. All rights reserved.
//

import UIKit
import TextFieldEffects

class ForgotPasswordViewController: UIViewController {
    @IBOutlet weak var emailTextField: TextFieldEffects?
    @IBOutlet weak var sendButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sendButton?.backgroundColor = UIColor.white
        sendButton?.layer.cornerRadius = 15
        sendButton?.clipsToBounds = true
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(ForgotPasswordViewController.handleTap))
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
    
    @IBAction func sendButtonAction(sender: UIButton) {
        
    }
}
