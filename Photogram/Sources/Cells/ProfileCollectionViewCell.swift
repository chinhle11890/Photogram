//
//  ProfileCollectionViewCell.swift
//  Photogram
//
//  Created by Chinh Le on 9/24/16.
//  Copyright © 2016 Chinh Le. All rights reserved.
//

import UIKit

class ProfileCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var avatarImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var photo: Photo? {
        didSet {
            if let image = photo?.image {
                avatarImageView.image = image
            }
        }
    }
}
