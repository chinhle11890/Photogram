//
//  ProfileViewController.swift
//  Photogram
//
//  Created by Chinh Le on 9/24/16.
//  Copyright © 2016 Chinh Le. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var photoCollectionView: UICollectionView!
    @IBOutlet weak var contactButton: UIButton!
    @IBOutlet weak var followingButton: UIButton!
    
    private let numberOfColumn: CGFloat = 3
    private let distanceOfColumns: CGFloat = 8
    private let photoCell = "ProfileCollectionViewCell"
    
    let photos = Photo.allPhotos()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoCollectionView.contentInset = UIEdgeInsetsMake(8, 8, 8, 8)
        photoCollectionView.showsVerticalScrollIndicator = false
        photoCollectionView.showsHorizontalScrollIndicator = false
        
        // Set corner radius
        contactButton?.layer.cornerRadius = 10
        contactButton?.clipsToBounds = true
        followingButton?.layer.cornerRadius = 10
        followingButton?.clipsToBounds = true
    }
    
    @IBAction func didClickBackButton(_ sender: AnyObject) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didClickEditProfileBUtton(_ sender: AnyObject) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    // MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (photoCollectionView.frame.width - 16 - distanceOfColumns*(numberOfColumn - 1))/numberOfColumn
        let photo = photos[indexPath.item] as Photo
        let image = photo.image
        let ratio = image.size.height/image.size.width
        
        return CGSize(width: width, height: width*ratio)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return distanceOfColumns
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return distanceOfColumns
    }
}
