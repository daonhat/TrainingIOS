//
//  Status.swift
//  TrainingIOS
//
//  Created by mod bibi on 7/28/17.
//  Copyright © 2017 DaoNhat. All rights reserved.
//

import Foundation
import UIKit

struct Status {
    var userName: String?
    var content: String?
    var avatar: UIImage?
    var type: Int?
    var image: UIImage?
    
    init(userName: String?, content: String?, avatar: UIImage?, type: Int?, image: UIImage?) {
        self.userName = userName
        self.content = content
        self.avatar = avatar
        self.type = type
        self.image = image
    }
}
