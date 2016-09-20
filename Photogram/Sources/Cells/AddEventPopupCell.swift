//
//  AddEventPopupCell.swift
//  Photogram
//
//  Created by Bao Nguyen on 9/20/16.
//  Copyright © 2016 Chinh Le. All rights reserved.
//

import UIKit

class AddEventPopupCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var setting: Setting? {
        didSet {
            nameLabel.text = setting?.title
            iconImageView.image = UIImage(named:setting!.imageName)
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Setting"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.white
        return label
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icm_like")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let containerView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    func setupViews() {
        containerView.addSubview(iconImageView)
        addSubview(nameLabel)
        addSubview(containerView)
        
        addConstraintsWithFormat("H:[v0]-8-[v1(40)]-16-|", views: nameLabel, containerView)
        addConstraintsWithFormat("V:|[v0]|", views: nameLabel)
        addConstraintsWithFormat("V:[v0(40)]", views: containerView)
        
        addConstraint(NSLayoutConstraint(item: containerView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        containerView.addConstraintsWithFormat("H:|-4-[v0]-4-|", views: iconImageView)
        containerView.addConstraintsWithFormat("V:|-4-[v0]-4-|", views: iconImageView)
        
        containerView.layer.cornerRadius = 20
        containerView.layer.masksToBounds = true
    }
}






