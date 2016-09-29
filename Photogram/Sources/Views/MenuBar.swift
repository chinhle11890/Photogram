//
//  SearchMenu.swift
//  Photogram
//
//  Created by Bao Nguyen on 2016-09-24.
//  Copyright © 2016 Chinh Le. All rights reserved.
//

import UIKit

protocol MenuBarDelegate: AnyObject {
    func menuBar(_ menuBar: MenuBar, didClickItemAt index: Int)
}

class MenuBar: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

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
    
    lazy var dataSource: [String] = {
        let path = Bundle.main.path(forResource: "SearchMenu", ofType: "plist")
        return NSArray(contentsOfFile: path!) as! [String]
    }()
    
    private var leftConstraint: NSLayoutConstraint!
    
    let cellId = "cellId"
    private var selectedIndex = 0
    weak var delegate: MenuBarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
        
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
                                              multiplier: 1/CGFloat(dataSource.count),
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
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCell
        
        cell.titleLabel.text = dataSource[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (selectedIndex == indexPath.item) {
            return
        }
        selectedIndex = indexPath.item
        let x = CGFloat(indexPath.item) * frame.width / CGFloat(dataSource.count)
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
                delegate.menuBar(self, didClickItemAt: indexPath.item)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item: CGFloat = CGFloat(dataSource.count)
        return CGSize(width: frame.width/item, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

class MenuCell: UICollectionViewCell {
    
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
    
    func setupViews() {
        addSubview(titleLabel)
        addConstraintsWithFormat("H:|-2-[v0]-2-|", views: titleLabel)
        addConstraintsWithFormat("V:|[v0]|", views: titleLabel)
    }
    
}
