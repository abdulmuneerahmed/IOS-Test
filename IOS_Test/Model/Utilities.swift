//
//  Utilities.swift
//  IOS_Test
//
//  Created by admin on 29/04/19.
//  Copyright © 2019 AcknoTech. All rights reserved.
//

import Foundation

func getApi(pageNumber page:Int = 1) -> String{
    return "https://hn.algolia.com/api/v1/search_by_date?tags=story&page=\(page)"
}
