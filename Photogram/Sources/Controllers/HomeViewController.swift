//
//  HomeViewController.swift
//  Photogram
//
//  Created by Bao Nguyen on 9/20/16.
//  Copyright © 2016 Chinh Le. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, AddEventPopupDelegate {

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
    
    lazy var addEventPopup: AddEventPopup = {
        let addEvent = AddEventPopup()
        addEvent.delegate = self;
        return addEvent
    }()
    
    @IBAction func didClickAddButton(_ sender: AnyObject) {
        addEventPopup.showSettings()
    }
    
    func addEvent(_ addEventPopup: AddEventPopup, didSelectedItemAt index: Int) {
        print(index)
        let eventType: AddEvent = AddEvent(rawValue: index) ?? .Event
        switch eventType {
        case .Event:
            break
        case .Photo:
            break
        }
    }

}
