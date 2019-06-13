//
//  HelperDateFormatter.swift
//  Movies
//
//  Created by mac on 6/13/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation

class HelperDateFormatter: NSObject {
    
    class func formatDate(dateString:String)->String
    {
        let fromDateFromatter = DateFormatter()
        fromDateFromatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let toDateFromatter = DateFormatter()
        toDateFromatter.dateFormat = "MMM dd,yyyy"
        
        if let date = fromDateFromatter.date(from: dateString) {
            return toDateFromatter.string(from: date)
        } else {
            return ""
        }
    }
}
