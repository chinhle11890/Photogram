//
//  AddEventViewController.swift
//  Photogram
//
//  Created by Chinh Le on 9/24/16.
//  Copyright © 2016 Chinh Le. All rights reserved.
//

import UIKit

class AddEventViewController: UIViewController {
    @IBOutlet weak var locationImageView: UIImageView!
    @IBOutlet weak var cameraImageView: UIImageView!
    @IBOutlet weak var privateButton: UIButton!
    @IBOutlet weak var publicButton: UIButton!
    @IBOutlet weak var uploadLabel: UILabel!
    
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set border and rounded
        privateButton.isSelected = true
        publicButton.isSelected = false
        
        uploadLabel?.layer.cornerRadius = 5
        uploadLabel?.clipsToBounds = true
        
        cameraImageView.layer.borderWidth = 1
        cameraImageView.layer.borderColor = UIColor.white.cgColor
        cameraImageView.layer.masksToBounds = false
        cameraImageView.layer.cornerRadius = 20
        cameraImageView.clipsToBounds = true
        
        locationImageView.layer.borderWidth = 1
        locationImageView.layer.borderColor = UIColor.white.cgColor
        locationImageView.layer.masksToBounds = false
        locationImageView.layer.cornerRadius = 20
        locationImageView.clipsToBounds = true
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(AddEventViewController.handleTap))
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
    
    @IBAction func didClickBackButton(_ sender: AnyObject) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didClickDoneButton(_ sender: AnyObject) {
        _ = navigationController?.popViewController(animated: true)
    }

    @IBAction func didClickCaptureButton(_ sender: AnyObject) {
        imagePicker =  UIImagePickerController()
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func privatePublicButtonAction(sender: UIButton) {
        privateButton.isSelected = !privateButton.isSelected
        publicButton.isSelected = !publicButton.isSelected
    }
}
