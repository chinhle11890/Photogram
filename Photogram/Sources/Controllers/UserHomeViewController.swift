//
//  UserHomeViewController.swift
//  Photogram
//
//  Created by Bao Nguyen on 9/21/16.
//  Copyright © 2016 Chinh Le. All rights reserved.
//

import UIKit

class UserHomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UserHomeCellDelegate, AddEventDelegate {

    @IBOutlet weak var profileTableView: UITableView!
    
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
    
    // MARK: - UserHomeCellDelegate
    func userHome(_ userHomeCell: UserHomeTableViewCell, didClickButtonAt index: NSIndexPath, button: UIButton) {
        let startingFrame = button.superview?.convert(button.frame, to: nil)
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
    
}
