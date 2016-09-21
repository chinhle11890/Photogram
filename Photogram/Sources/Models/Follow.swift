//
//  Follow.swift
//  Photogram
//
//  Created by Bao Nguyen on 9/21/16.
//  Copyright © 2016 Chinh Le. All rights reserved.
//

import UIKit

class Follow {
    class func allFollows() -> [Follow] {
        var follows = [Follow]()
        if let url = Bundle.main.url(forResource: "Follows", withExtension: "plist") {
            if let followsFromPlist = NSArray(contentsOf: url) {
                for dictionary in followsFromPlist {
                    let follow = Follow(dictionary: dictionary as! NSDictionary)
                    follows.append(follow)
                }
            }
            
        }
        return follows
    }
    
    var follow: Bool
    var image: UIImage
    var username: String
    var followCount: Int
    
    init(follow: Bool, image: UIImage, username: String, followCount: Int) {
        self.follow = follow
        self.image = image
        self.username = username
        self.followCount = followCount
    }
    
    convenience init(dictionary: NSDictionary) {
        let choose = dictionary["follow"] as? Bool ?? false
        let photo = dictionary["image"] as? String
        let image = UIImage(named: photo!)
        let username = dictionary["username"] as? String
        let followCount = dictionary["followCount"] as? Int ?? 100
        self.init(follow: choose, image: image!, username: username!, followCount: followCount)
    }

}
