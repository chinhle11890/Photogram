//
//  FollowTableViewCell.swift
//  Photogram
//
//  Created by Bao Nguyen on 9/21/16.
//  Copyright © 2016 Chinh Le. All rights reserved.
//

import UIKit

protocol FollowCellDelegate: AnyObject {
    func followCell(_ followCell: FollowTableViewCell, didClickButtonAt indexPath: NSIndexPath, state: Bool)
}

class FollowTableViewCell: UITableViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var followLabel: UILabel!
    
    var indexPath: NSIndexPath?
    weak var delegate: FollowCellDelegate?
    
    var follow: Follow? {
        didSet {
            if let avatar = follow?.image {
                avatarImageView.image = avatar
            }
            if let username = follow?.username {
                usernameLabel.text = username
            }
            if let followCount = follow?.followCount {
                followLabel.text = "\(followCount)"
            }
            if let followed = follow?.follow {
                changeStateFollowButton(followed)
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        followButton.layer.borderWidth = 1
        followButton.layer.borderColor = UIColor.rgb(red: 243, green: 51, blue: 100).cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func didClickFollowButton(_ sender: AnyObject) {
        if var followed = follow?.follow {
            followed = !followed
            changeStateFollowButton(followed)
            if let delegate = delegate {
                delegate.followCell(self, didClickButtonAt: indexPath!, state: followed)
            }
        }
    }
    
    func changeStateFollowButton(_ state: Bool) {
        if !state {
            followButton.setTitle("+   Follow", for: .normal)
        } else {
            followButton.setTitle("Following", for: .normal)
        }
    }

}
