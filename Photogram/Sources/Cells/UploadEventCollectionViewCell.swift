//
//  UploadEventCollectionViewCell.swift
//  Photogram
//
//  Created by Bao Nguyen on 9/21/16.
//  Copyright © 2016 Chinh Le. All rights reserved.
//

import UIKit

class UploadEventCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var chooseImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var photo: Photo? {
        didSet {
            if let choose: Bool = photo?.choose {
                chooseImageView.image = choose ? UIImage(named: "icn_choose") : nil
            }
            if let image = photo?.image {
                avatarImageView.image = image
            }
        }
    }
}
