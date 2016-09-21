//
//  UserHomeTableViewCell.swift
//  Photogram
//
//  Created by Bao Nguyen on 9/21/16.
//  Copyright © 2016 Chinh Le. All rights reserved.
//

import UIKit

protocol UserHomeCellDelegate: AnyObject {
    func userHome(_ userHomeCell: UserHomeTableViewCell, didClickButtonAt index: NSIndexPath, button: UIButton)
}

class UserHomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var eventnameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var optionMenuButton: UIButton!
    @IBOutlet weak var coverImageView: UIImageView!
    
    weak var delegate: UserHomeCellDelegate?
    var indexPath: NSIndexPath!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func didClickOptionButton(_ sender: AnyObject) {
        if let delegate = delegate {
            delegate.userHome(self, didClickButtonAt: indexPath, button: sender as! UIButton)
        }
    }
}
