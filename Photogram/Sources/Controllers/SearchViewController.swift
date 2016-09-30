//
//  SearchViewController.swift
//  Photogram
//
//  Created by Bao Nguyen on 2016-09-24.
//  Copyright © 2016 Chinh Le. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, MenuBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout {
    
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
        
        self.setupCollectionView()
    }
    
    func setupCollectionView(){
        photoCollectionView.showsVerticalScrollIndicator = false
        photoCollectionView.showsHorizontalScrollIndicator = false
        
        // Create a waterfall layout
        let layout = CHTCollectionViewWaterfallLayout()
        
        // Change individual layout attributes for the spacing between cells
        layout.minimumColumnSpacing = 8.0
        layout.minimumInteritemSpacing = 8.0
        layout.columnCount = 3
        
        // Collection view attributes
        photoCollectionView.autoresizingMask = [UIViewAutoresizing.flexibleHeight, UIViewAutoresizing.flexibleWidth]
        photoCollectionView.alwaysBounceVertical = true
        
        // Add the waterfall layout to your collection view
        photoCollectionView.collectionViewLayout = layout
    }
    
    @IBAction func didClickBackButton(_ sender: AnyObject) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    // MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photoCell, for: indexPath) as! UploadEventCollectionViewCell
        let photo = photos[indexPath.item]
        cell.photo = photo
        return cell
    }
    
    // MARK: CHTCollectionViewDelegateWaterfallLayout
    func collectionView (_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,
                         sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        let width = (photoCollectionView.frame.width - 16 - 8*(numberOfColumn - 1))/numberOfColumn
        let photo = photos[indexPath.item] as Photo
        let image = photo.image
        let ratio = image.size.height/image.size.width
        return CGSize(width: width, height: width*ratio)
    }
    
    func collectionView (_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                         insetForSectionAtIndex section: NSInteger) -> UIEdgeInsets {
        return UIEdgeInsetsMake(8, 8, 8, 8)
    }
    
    //MARK: - MenuBarDelegate
    func menuBar(_ menuBar: MenuBar, didClickItemAt index: Int) {
        print("--->", index)
    }

}
