//
//  HorizontalMenu.swift
//  Photogram
//
//  Created by Bao Nguyen on 9/26/16.
//  Copyright © 2016 Chinh Le. All rights reserved.
//

import UIKit

protocol HorizontalMenuDelegate: AnyObject {
    func horizontalMenu(_ horizontalMenu: HorizontalMenu, didClickItemAt index: Int)
}

class HorizontalMenu: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    lazy var horizontalBar: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 243, green: 51, blue: 100)
        return view
    }()
    
    var menuType: HorizontalMenuType! {
        didSet {
            let path = Bundle.main.path(forResource: "HorizontalMenu", ofType: "plist")
            let dictionary = NSDictionary(contentsOfFile: path!)
            settings =  dictionary![menuType.rawValue] as! [AnyObject]
            setupView()
            collectionView.reloadData()
        }
    }

    private var settings: [AnyObject] = [AnyObject]()
    
    private var leftConstraint: NSLayoutConstraint!
    
    let cellId = "cellId"
    private var selectedIndex = 0
    weak var delegate: HorizontalMenuDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func setupView() {
        collectionView.register(HorizontalCell.self, forCellWithReuseIdentifier: cellId)
        
        addSubview(collectionView)
        addConstraintsWithFormat("H:|[v0]|", views: collectionView)
        addConstraintsWithFormat("V:|[v0]|", views: collectionView)
        
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        selectedIndex = 0
        collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: UICollectionViewScrollPosition())
        
        addSubview(horizontalBar)
        addConstraintsWithFormat("V:[v0(2)]|", views: horizontalBar)
        addConstraint(NSLayoutConstraint.init(item: horizontalBar,
                                              attribute: .width,
                                              relatedBy: .equal,
                                              toItem: self,
                                              attribute: .width,
                                              multiplier: 1/CGFloat(settings.count),
                                              constant: 0))
        leftConstraint = NSLayoutConstraint.init(item: horizontalBar,
                                                 attribute: .leading,
                                                 relatedBy: .equal,
                                                 toItem: self,
                                                 attribute: .leading,
                                                 multiplier: 1,
                                                 constant: 0)
        addConstraint(leftConstraint)

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HorizontalCell
        
        let dictionary = settings[indexPath.row]
        let setting = Setting(title: dictionary["title"] as! String, imageName: dictionary["image"] as! String)
        cell.setting = setting

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (selectedIndex == indexPath.item) {
            return
        }
        selectedIndex = indexPath.item
        let x = CGFloat(indexPath.item) * frame.width / CGFloat(settings.count)
        leftConstraint.constant = x;
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 1,
                       options: .curveEaseInOut,
                       animations: {
                        self.layoutIfNeeded()
        }) { (success: Bool) in
            if let delegate = self.delegate {
                delegate.horizontalMenu(self, didClickItemAt: indexPath.item)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item: CGFloat = CGFloat(settings.count)
        return CGSize(width: frame.width/item, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class HorizontalCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.text = "Title"
        title.textColor = UIColor.gray
        title.font = UIFont.systemFont(ofSize: 13, weight: UIFontWeightMedium)
        title.textAlignment = .center
        return title
    }()
    
    lazy var iconImageView: UIImageView = {
        let image = UIImage(named: "icn_user")
        let imageView = UIImageView()
        imageView.image = image?.withRenderingMode(.alwaysTemplate)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    func setupViews() {
        addSubview(iconImageView)
        addSubview(titleLabel)
        addConstraintsWithFormat("H:|-2-[v0(30)]-2-[v1]-2-|", views: iconImageView , titleLabel)
        addConstraintsWithFormat("V:|[v0]|", views: titleLabel)
        addConstraintsWithFormat("V:[v0(30)]", views: iconImageView)
        addConstraint(NSLayoutConstraint.init(item: iconImageView,
                                              attribute: .centerX,
                                              relatedBy: .equal,
                                              toItem: self,
                                              attribute: .centerX,
                                              multiplier: 1,
                                              constant: 0))
    }
    
    var setting: Setting? {
        didSet {
            titleLabel.text = setting?.title
            iconImageView.image = UIImage(named:setting!.imageName)
        }
    }
    
}

