//
//  File.swift
//  TrainingIOS
//
//  Created by DaoNhat on 8/22/17.
//  Copyright © 2017 DaoNhat. All rights reserved.
//

import Foundation
import UIKit

struct User {
    var userName: String?
    var email: String?
    var avatar: UIImage?
    var dob: Date
    
    init(userName: String?, email: String?, avatar: UIImage?, dob: Date) {
        self.userName = userName
        self.email = email
        self.avatar = avatar
        self.dob = dob
    }
}
