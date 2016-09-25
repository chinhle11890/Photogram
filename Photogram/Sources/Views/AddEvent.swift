//
//  AddEvent.swift
//  Photogram
//
//  Created by Bao Nguyen on 9/20/16.
//  Copyright © 2016 Chinh Le. All rights reserved.
//

import UIKit

class Setting: NSObject {
    let title: String
    let imageName: String
    
    init(title: String, imageName: String) {
        self.title = title
        self.imageName = imageName
    }
}

protocol AddEventDelegate: AnyObject {
    func addEvent(_ addEvent: AddEvent, didSelectedItemAt index: Int);
}

class AddEvent: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    weak var delegate: AddEventDelegate?
    
    private let cellId = "eventCell"
    private let cellHeight: CGFloat = 50
    private var startingFrame: CGRect!
    
    var menuType: AddEventMenu! {
        didSet {
            let path = Bundle.main.path(forResource: "AddEventMenu", ofType: "plist")
            let dictionary = NSDictionary(contentsOfFile: path!)
            settings =  dictionary![menuType.rawValue] as! [AnyObject]

        }
    }
    
    private lazy var blackView: UIView = {
        let blackView = UIView()
        blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissView)))
        
//        let image = UIImageView()
//        image.image = UIImage(named: "icn_back_circle_red")
//        image.contentMode = .scaleToFill
//        blackView.addSubview(image)
//        blackView.addConstraintsWithFormat("H:[v0(30)]-20-|", views: image)
//        blackView.addConstraintsWithFormat("V:[v0(30)]-20-|", views: image)
        
        let button = UIButton()
        button.setImage(UIImage(named: "icn_back_circle_red"), for: .normal)
        button.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        blackView.addSubview(button)
        blackView.addConstraintsWithFormat("H:[v0(30)]-20-|", views: button)
        blackView.addConstraintsWithFormat("V:[v0(30)]-20-|", views: button)
        
        return blackView
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.clear
        return cv
    }()
    
    private var settings: [AnyObject] = [AnyObject]()
    
    override init() {
        super.init()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(AddEventPopupCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func showSettings(_ atFrame: CGRect) {
        //show menu
        startingFrame = atFrame
        if let window = UIApplication.shared.keyWindow {
            
            window.addSubview(blackView)
            
            window.addSubview(collectionView)
            
            let height: CGFloat = CGFloat(settings.count) * cellHeight
            collectionView.frame = CGRect(x: 0, y: self.startingFrame.origin.y + self.startingFrame.height, width: window.frame.width, height: 0)
            
            blackView.frame = window.frame
            blackView.alpha = 0
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.blackView.alpha = 1
                
                self.collectionView.frame = CGRect(x: 0, y: self.startingFrame.origin.y + self.startingFrame.height, width: self.collectionView.frame.width, height: height)
                
                }, completion: nil)
        }
    }
    
    @objc private func dismissView() {
        handleDismiss()
    }
    
    func handleDismiss(_ completion: (()->(Void))? = nil) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.blackView.alpha = 0
            self.collectionView.frame = CGRect(x: 0, y: self.startingFrame.origin.y + self.startingFrame.height, width: self.collectionView.frame.width, height: 0)
            
        }) { (completed: Bool) in
            if completion != nil {
                completion!()
            }
        }
    }
    
    // MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AddEventPopupCell
        
        let dictionary = settings[indexPath.row]
        let setting = Setting(title: dictionary["title"] as! String, imageName: dictionary["image"] as! String)
        cell.setting = setting
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        handleDismiss {
            if let delegate = self.delegate {
                delegate.addEvent(self, didSelectedItemAt: indexPath.row)
            }
        }
    }
}
