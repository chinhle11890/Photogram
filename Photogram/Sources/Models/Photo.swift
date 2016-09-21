//
//  Photo.swift
//  Photogram
//
//  Created by Bao Nguyen on 9/21/16.
//  Copyright © 2016 Chinh Le. All rights reserved.
//

import UIKit

class Photo {
    
    class func allPhotos() -> [Photo] {
        var photos = [Photo]()
        if let url = Bundle.main.url(forResource: "Photos", withExtension: "plist") {
            if let photosFromPlist = NSArray(contentsOf: url) {
                for dictionary in photosFromPlist {
                    let photo = Photo(dictionary: dictionary as! NSDictionary)
                    photos.append(photo)
                }
            }

        }
        return photos
    }
    
    var choose: Bool
    var image: UIImage
    
    init(choose: Bool, image: UIImage) {
        self.choose = choose
        self.image = image
    }
    
    convenience init(dictionary: NSDictionary) {
        let choose = dictionary["choose"] as? Bool
        let photo = dictionary["image"] as? String
        let image = UIImage(named: photo!)
        self.init(choose: choose!, image: image!)
    }
    
}
