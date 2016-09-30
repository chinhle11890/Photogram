//
//  ProfilePageItemViewController.swift
//  Photogram
//
//  Created by Chinh Le on 9/25/16.
//  Copyright © 2016 Chinh Le. All rights reserved.
//

import UIKit

class ProfilePageItemViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout {
    var itemIndex: Int = 0
    
    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    private let numberOfColumn: CGFloat = 3
    private let distanceOfColumns: CGFloat = 8
    private let photoCell = "ProfileCollectionViewCell"
    
    let photos = Photo.allPhotos()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupCollectionView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupCollectionView(){
        // Create a waterfall layout
        let layout = CHTCollectionViewWaterfallLayout()
        
        // Change individual layout attributes for the spacing between cells
        layout.minimumColumnSpacing = 8.0
        layout.minimumInteritemSpacing = 8.0
        layout.columnCount = 3
        
        // Add the waterfall layout to your collection view
        photoCollectionView.collectionViewLayout = layout
    }
    
    // MARK: - UICollectionViewDelegate, UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photoCell, for: indexPath) as! ProfileCollectionViewCell
        let photo = photos[indexPath.item]
        cell.photo = photo
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
    
    // MARK: CHTCollectionViewDelegateWaterfallLayout
    func collectionView (_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,
                         sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        let width = (photoCollectionView.frame.width - 16 - distanceOfColumns*(numberOfColumn - 1))/numberOfColumn
        let photo = photos[indexPath.item] as Photo
        let image = photo.image
        let ratio = image.size.height/image.size.width
        return CGSize(width: width, height: width*ratio)
    }
    
    func collectionView (_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                                        insetForSectionAtIndex section: NSInteger) -> UIEdgeInsets {
        return UIEdgeInsetsMake(8, 8, 8, 8)
    }
}
