//
//  Services.swift
//  IOS_Test
//
//  Created by admin on 29/04/19.
//  Copyright © 2019 AcknoTech. All rights reserved.
//

import Foundation

class CellDataService{
    static let service = CellDataService()
    private init(){}
    
    var cellData = [CellData]()
    
    func getCellItems()->[CellData]{
        return cellData
    }
    
}
