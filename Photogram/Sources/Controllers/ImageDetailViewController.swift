//
//  ImageDetailViewController.swift
//  Photogram
//
//  Created by Bao Nguyen on 9/22/16.
//  Copyright © 2016 Chinh Le. All rights reserved.
//

import UIKit

class ImageDetailViewController: UIViewController, AddEventDelegate {

    lazy var addEventPopup: AddEvent = {
        let addEvent = AddEvent()
        addEvent.delegate = self
        addEvent.menuType = .UserHome
        return addEvent
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func didClickBackButton(_ sender: AnyObject) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didClickOptionMenu(_ sender: AnyObject) {
        if let button = sender as? UIButton {
            let startingFrame = button.superview?.convert(button.frame, to: nil)
            addEventPopup.showSettings(startingFrame!)
        }
    }
    
    // MARK: - AddEventDelegate
    // TODO: NEED IMPLEMENT
    func addEvent(_ addEvent: AddEvent, didSelectedItemAt index: Int) {
        let eventType = OptionMenu(rawValue: index) ?? .Download
        switch eventType {
        case .Download:
            
            break
        case .Save:
            break
        }
        
    }

}
