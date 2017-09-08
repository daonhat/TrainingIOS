//
//  Status.swift
//  TrainingIOS
//
//  Created by mod bibi on 7/28/17.
//  Copyright © 2017 DaoNhat. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

struct Status {
    var userName: String?
    var content: String?
    var avatar: UIImage?
    var image: UIImage?
    var comment_cnt: Int?
    var created_at: String?
    var id: Int!
    var like_cnt: Int?
    var share_cnt: Int?
    var status: String?
    var type: String?
    var update_at: String?
    var user_post: Int?
    
    

    init(jsonObject: AnyObject?) {
        // check jsonObject if it is nil, return
        guard let jsonData = jsonObject else {return}
        
        // using SwiftyJSON
        let json = JSON(jsonData)
        
        self.comment_cnt      = json["comment_cnt"].int
        self.created_at       = json["created_at"].string
        self.id               = json["id"].int
        self.like_cnt         = json["like_cnt"].int
        self.share_cnt        = json["share_cnt"].int
        self.status           = json["status"].string
        self.type           = json["type"].string
        self.update_at        = json["update_at"].string
        self.user_post        = json["user_post"]["id"].int
    }
    
    
}
