//
//  Array+Shuffle.swift
//  TrainingIOS
//
//  Created by DaoNhat on 9/1/17.
//  Copyright © 2017 DaoNhat. All rights reserved.
//

import Foundation

extension Array
{
    /** Randomizes the order of an array's elements. */
    mutating func shuffle()
    {
        for _ in 0..<((count>0) ? (count-1) : 0) {
            sort { (_,_) in arc4random() < arc4random() }
        }
    }
}


