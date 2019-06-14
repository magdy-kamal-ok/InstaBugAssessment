//
//  HelperDateFormatter.swift
//  Movies
//
//  Created by mac on 6/13/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation

class HelperDateFormatter: NSObject {
    
    class func formatDate(date:Date)->String
    {
        let dateFromatter = DateFormatter()
        dateFromatter.dateFormat = "MMM dd,yyyy"
        return dateFromatter.string(from: date)
    }
    
    class func formatDateAsDashed(date:Date)->String
    {
        let dateFromatter = DateFormatter()
        dateFromatter.dateFormat = "yyyy-mm-dd"
        return dateFromatter.string(from: date)
    }
    
    class func getDateFromString(dateString:String)->Date
    {
        let dateFromatter = DateFormatter()
        dateFromatter.dateFormat = "yyyy-mm-dd"
        if let date = dateFromatter.date(from: dateString)
        {
            return date
        }
        else
        {
            assertionFailure("failed to convert Date")
           return Date()
        }
        
    }
}
