//
//  UserHomeViewController.swift
//  Photogram
//
//  Created by Bao Nguyen on 9/21/16.
//  Copyright © 2016 Chinh Le. All rights reserved.
//

import UIKit
import ALRadial

class UserHomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UserHomeCellDelegate, AddEventDelegate, ALRadialMenuDelegate {

    @IBOutlet weak var profileTableView: UITableView!
    @IBOutlet weak var mainMenuButton: UIButton!
    
    lazy var menuButton: ALRadialMenu = {
        let button = ALRadialMenu()
        button.delegate = self
        return button
    }()
    
    private let userCell = "userCell"
    
    lazy var addEventPopup: AddEvent = {
        let addEvent = AddEvent()
        addEvent.delegate = self
        addEvent.menuType = .UserHome
        return addEvent
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.profileTableView.estimatedRowHeight = 400
        self.profileTableView.rowHeight = UITableViewAutomaticDimension
    }

    @IBAction func didClickBackButton(_ sender: AnyObject) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    // MARK: - UITableViewDelegate, UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: userCell, for: indexPath) as! UserHomeTableViewCell
        cell.indexPath = indexPath as NSIndexPath!
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
    
    // MARK: - UserHomeCellDelegate
    func userHome(_ userHomeCell: UserHomeTableViewCell, didClickButtonAt index: NSIndexPath, button: UIButton) {
        let startingFrame = button.superview?.convert(button.frame, to: nil)
        mainMenuButton.setImage(UIImage(named: "icn_back"), for: .normal)
        addEventPopup.showSettings(startingFrame!)
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
    
    @IBAction func didClickMenuButton(_ sender: AnyObject) {
        let frame = (sender as! UIButton).superview?.convert(sender.frame, to: nil)
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
        menuButton.itemsWillDisapear(into: mainMenuButton)
        mainMenuButton.setImage(UIImage(named: "icn_home_menu"), for: .normal)
        if index == 1 { // home
//            _ = navigationController?.popViewController(animated: true)
            _ = navigationController?.popToRootViewController(animated: true)
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
