//
//  SearchViewController.swift
//  Photogram
//
//  Created by Bao Nguyen on 2016-09-24.
//  Copyright © 2016 Chinh Le. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, MenuBarDelegate {
    
    @IBOutlet weak var menuBarContainer: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    private let numberOfColumn: CGFloat = 3
    private let photoCell = "photoCell"
    
    let photos = Photo.allPhotos()
    
    lazy var menuBar: MenuBar = {
        let menu = MenuBar()
        menu.delegate = self
        return menu
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        menuBarContainer.addSubview(menuBar)
        menuBarContainer.addConstraintsWithFormat("H:|[v0]|", views: menuBar)
        menuBarContainer.addConstraintsWithFormat("V:|[v0]|", views: menuBar)
        searchTextField.becomeFirstResponder()
        
//        photoCollectionView.contentInset = UIEdgeInsetsMake(8, 8, 8, 8)
//        photoCollectionView.showsVerticalScrollIndicator = false
//        photoCollectionView.showsHorizontalScrollIndicator = false
    }
    
    @IBAction func didClickBackButton(_ sender: AnyObject) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    // MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photoCell, for: indexPath) as! UploadEventCollectionViewCell
//        let photo = photos[indexPath.item]
//        cell.photo = photo
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photoCell, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (photoCollectionView.frame.width - 16 - 8*3)/numberOfColumn
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    //MARK: - MenuBarDelegate
    func menuBar(_ menuBar: MenuBar, didClickItemAt index: Int) {
        print("--->", index)
    }

}
