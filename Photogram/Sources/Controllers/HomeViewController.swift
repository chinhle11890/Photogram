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
    
    lazy var blackView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        view.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(dismissView)))
        return view
    }()
    
    func dismissView() {
        blackView.isHidden = true
        menuButton.itemsWillDisapear(into: mainMenuButton)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.delegate = self
        
        blackView.frame = view.frame
        view.addSubview(blackView)
        blackView.isHidden = true
        view.bringSubview(toFront: mainMenuButton)
    }
    
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
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: StoryBoardId.addEventController) as? AddEventViewController {
                navigationController?.pushViewController(vc, animated: true)
            }
            break
        case .Photo:
            if let vc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: StoryBoardId.uploadEventController) as? UploadEventViewController {
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
        menuButton.buttonsWillAnimateFromButton(sender, withFrame: frame!, in: self.view)
        blackView.isHidden = !blackView.isHidden
    }
    
    // MARK: ALRadialMenuDelegate
    
    func numberOfItems(in radialMenu: ALRadialMenu!) -> Int {
        return 5
    }
    
    func arcSize(for radialMenu: ALRadialMenu!) -> Int {
        return 90
    }
    
    func arcRadius(for radialMenu: ALRadialMenu!) -> Int {
        return 100
    }
    
    func radialMenu(_ radialMenu: ALRadialMenu!, imageFor index: Int) -> UIImage! {
        if index == 1 {
            return UIImage(named: "icn_menu_home")
        } else if index == 2 {
            return UIImage(named: "icn_menu_search")
        } else if index == 3 {
            return UIImage(named: "icn_menu_camera")
        } else if index == 4 {
            return UIImage(named: "icn_menu_add_user")
        } else if index == 5 {
            return UIImage(named: "icn_menu_user")
        }
        return UIImage(named: "icn_menu_user")
    }
    
    func radialMenu(_ radialMenu: ALRadialMenu!, didSelectItemAt index: Int) {
        print("--> ", index)
                menuButton.itemsWillDisapear(into: mainMenuButton)
        UIView.animate(withDuration: 0.25, animations: { 
            self.blackView.isHidden = true
            }) { (success) in
                self.gotoScreen(index)
        }
    }
    
    func gotoScreen(_ index: Int) {
        if index == 1 { // home
            
        } else if index == 2 {  // search
            if let vc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: StoryBoardId.searchController) as? SearchViewController {
                navigationController?.pushViewController(vc, animated: true)
            }
        } else if index == 3 {  // camera
            
        } else if index == 4 {  // add user
            if let vc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: StoryBoardId.followController) as? FollowViewController {
                navigationController?.pushViewController(vc, animated: true)
            }
        } else if index == 5 {  // user
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: StoryBoardId.profileController) as? ProfileViewController {
                navigationController?.pushViewController(vc, animated: true)
            }
        }

    }
    
    public func arcStart(for radialMenu: ALRadialMenu!) -> Int {
        return 180
        
    }
    public func buttonSize(for radialMenu: ALRadialMenu!) -> Float {
        return 40.0
    }

}
