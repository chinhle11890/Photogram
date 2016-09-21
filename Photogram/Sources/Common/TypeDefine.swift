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

class StoryBoardId: NSObject {
    static let uploadEventController = "UploadEventController"
    static let followController = "FollowController"
}
