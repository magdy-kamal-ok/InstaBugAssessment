//
//  HelperDateFormatter.swift
//  Movies
//
//  Created by mac on 6/13/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation

class HelperDateFormatter: NSObject {
    
    class func formatDate(date:Date, format:String)->String
    {
        let dateFromatter = DateFormatter()
        dateFromatter.dateFormat = format
        return dateFromatter.string(from: date)
    }
    
    
    class func getDateFromString(dateString:String, format:String)->Date
    {
        let dateFromatter = DateFormatter()
        dateFromatter.dateFormat = format
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
