//
//  SignInViewController.swift
//  Photogram
//
//  Created by Chinh Le on 9/19/16.
//  Copyright © 2016 Chinh Le. All rights reserved.
//

import UIKit
import TextFieldEffects
import QuartzCore

class SignInViewController: UIViewController {
    @IBOutlet weak var usernameTextField: TextFieldEffects?
    @IBOutlet weak var passwordTextField: TextFieldEffects?
    @IBOutlet weak var signInButton: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        signInButton?.backgroundColor = UIColor.white
        signInButton?.layer.cornerRadius = (signInButton?.frame.width)!
        signInButton?.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func forgotPasswordButtonAction(sender: UIButton) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let signupVC : ForgotPasswordViewController = storyboard.instantiateViewController(withIdentifier: "ForgotPasswordViewController") as! ForgotPasswordViewController
        self.present(signupVC, animated: true, completion: nil)
    }
    
    @IBAction func signInButtonAction(sender: UIButton) {
        
    }
    
    @IBAction func signupButtonAction(sender: UIButton) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let signupVC : SignupViewController = storyboard.instantiateViewController(withIdentifier: "SignupViewController") as! SignupViewController
        self.present(signupVC, animated: true, completion: nil)
    }
}
