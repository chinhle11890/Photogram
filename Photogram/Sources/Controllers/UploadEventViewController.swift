//
//  UploadEventViewController.swift
//  Photogram
//
//  Created by Bao Nguyen on 9/21/16.
//  Copyright © 2016 Chinh Le. All rights reserved.
//

import UIKit

class UploadEventViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var photoCollectionView: UICollectionView!
    private let numberOfColumn: CGFloat = 3
    private let photoCell = "photoCell"
    
    let photos = Photo.allPhotos()

    override func viewDidLoad() {
        super.viewDidLoad()
        photoCollectionView.contentInset = UIEdgeInsetsMake(8, 8, 8, 8)
        photoCollectionView.showsVerticalScrollIndicator = false
        photoCollectionView.showsHorizontalScrollIndicator = false
    }
    
    @IBAction func didClickBackButton(_ sender: AnyObject) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didClickDoneBUtton(_ sender: AnyObject) {
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = photos[indexPath.row]
        photo.choose = !photo.choose
        collectionView.reloadItems(at: [indexPath])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 16 - 8*(numberOfColumn - 1))/numberOfColumn
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}
