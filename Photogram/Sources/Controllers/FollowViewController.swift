//
//  FollowViewController.swift
//  Photogram
//
//  Created by Bao Nguyen on 9/21/16.
//  Copyright © 2016 Chinh Le. All rights reserved.
//

import UIKit

class FollowViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FollowCellDelegate {

    @IBOutlet weak var followTableView: UITableView!
    private let followCell = "followCell"
    
    let follows = Follow.allFollows()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didClickBackButton(_ sender: AnyObject) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    // MARK: - UITableViewDelegate, UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return follows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: followCell, for: indexPath) as! FollowTableViewCell
        cell.follow = follows[indexPath.row]
        cell.indexPath = indexPath as NSIndexPath?
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    // MARK: - FollowCellDelegate
    func followCell(_ followCell: FollowTableViewCell, didClickButtonAt indexPath: NSIndexPath, state: Bool) {
        print(indexPath.row, " ", state)
        let follow = follows[indexPath.row]
        follow.follow = state
//        followTableView.reloadRows(at: [indexPath as IndexPath], with: .automatic)
    }
    
}
