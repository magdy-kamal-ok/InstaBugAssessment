//
//  MoviesHelperDateFormatterTests.swift
//  MoviesTests
//
//  Created by mac on 6/15/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import XCTest

@testable import Movies

class MoviesHelperDateFormatterTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testFormatStringFromDate()
    {
        let stringDate = "2019-03-22"
        let formatedDate = HelperDateFormatter.getDateFromString(dateString: stringDate, format: Constants.YEAR_MONTH_DAY_FORMAT)
        XCTAssert(type(of: formatedDate)==Date.self)
    }
    
    func testFormatDateToShortMonthFormat()
    {
        let stringDate = "2019-03-22"
        let formatedDate = HelperDateFormatter.getDateFromString(dateString: stringDate, format: Constants.YEAR_MONTH_DAY_FORMAT)
        let formatedDateString = HelperDateFormatter.formatDate(date: formatedDate, format: Constants.SHORTMONTH_DAY_YEAR_FORMAT)
        XCTAssert(formatedDateString=="Mar 22,2019")
    }
    

}
