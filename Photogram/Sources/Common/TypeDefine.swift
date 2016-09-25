//
//  TypeDefine.swift
//  Photogram
//
//  Created by Bao Nguyen on 9/20/16.
//  Copyright © 2016 Chinh Le. All rights reserved.
//

import UIKit

enum AddEventType: Int {
    case Event = 0
    case Photo = 1
}

enum OptionMenu: Int {
    case Download = 0
    case Save = 1
}

enum AddEventMenu: String {
    case Home = "home"
    case UserHome = "userhome"
}

class StoryBoardId: NSObject {
    static let uploadEventController = "UploadEventController"
    static let followController = "FollowController"
    static let searchController = "SearchController"
    static let addEventController = "AddEventViewController"
    static let profileController = "ProfileViewController"
}
