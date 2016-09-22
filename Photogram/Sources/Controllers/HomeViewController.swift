//
//  HomeViewController.swift
//  Photogram
//
//  Created by Bao Nguyen on 9/20/16.
//  Copyright © 2016 Chinh Le. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, AddEventDelegate, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.delegate = self
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
    
    lazy var addEventPopup: AddEvent = {
        let addEvent = AddEvent()
        addEvent.delegate = self
        addEvent.menuType = .Home
        return addEvent
    }()
    
    @IBAction func didClickAddButton(_ sender: AnyObject) {
        let startingFrame = (sender as! UIButton).superview?.convert(sender.frame, to: nil)
        addEventPopup.showSettings(startingFrame!)
    }
    
    func addEvent(_ addEvent: AddEvent, didSelectedItemAt index: Int) {
        let eventType = AddEventType(rawValue: index) ?? .Event
        switch eventType {
        case .Event:
            if let vc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: StoryBoardId.uploadEventController) as? UploadEventViewController {
                navigationController?.pushViewController(vc, animated: true)
            }
            break
        case .Photo:
            if let vc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: StoryBoardId.followController) as? FollowViewController {
                navigationController?.pushViewController(vc, animated: true)
            }
            break
        }
    }
    
    // MARK : UINavigationControllerDelegate
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
//        if viewController is HomeTableViewController {
//            self.navigationController?.setNavigationBarHidden(true, animated: animated)
//        } else {
//            self.navigationController?.setNavigationBarHidden(true, animated: animated)
//        }
    }

}
