//
//  HomeViewController.swift
//  Photogram
//
//  Created by Bao Nguyen on 9/20/16.
//  Copyright © 2016 Chinh Le. All rights reserved.
//

import UIKit
import ALRadial

class HomeViewController: UIViewController, AddEventDelegate, UINavigationControllerDelegate, ALRadialMenuDelegate {
    
    @IBOutlet weak var mainMenuButton: UIButton!
    
    lazy var menuButton: ALRadialMenu = {
        let button = ALRadialMenu()
        button.delegate = self
        return button
    }()

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
    }
    
    
    @IBAction func didClickMenuButton(_ sender: AnyObject) {
        let frame = (sender as! UIButton).superview?.convert(sender.frame, to: nil)
        print(frame)
        menuButton.buttonsWillAnimateFromButton(sender, withFrame: frame!, in: self.view)
    }
    
    // MARK: ALRadialMenuDelegate
    
    func numberOfItems(in radialMenu: ALRadialMenu!) -> Int {
        return 5
    }
    
    func arcSize(for radialMenu: ALRadialMenu!) -> Int {
        return 90
    }
    
    func arcRadius(for radialMenu: ALRadialMenu!) -> Int {
        return 120
    }
    
    func radialMenu(_ radialMenu: ALRadialMenu!, imageFor index: Int) -> UIImage! {
        return UIImage(named: "icn_menu_user")
    }
    
    func radialMenu(_ radialMenu: ALRadialMenu!, didSelectItemAt index: Int) {
        print("ahihi ", index)
        menuButton.itemsWillDisapear(into: mainMenuButton)
    }
    
    public func arcStart(for radialMenu: ALRadialMenu!) -> Int {
        return 180
        
    }
    public func buttonSize(for radialMenu: ALRadialMenu!) -> Float {
        return 40.0
    }

}
