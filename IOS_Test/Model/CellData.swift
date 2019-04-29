//
//  CellData.swift
//  IOS_Test
//
//  Created by admin on 29/04/19.
//  Copyright © 2019 AcknoTech. All rights reserved.
//

import Foundation

struct CellData {
    let title:String
    let date:String
    let numberofPages:Int
    init(title:String,date:String,numberofPages:Int) {
        self.title = title
        self.date = date
        self.numberofPages = numberofPages
    }
}
