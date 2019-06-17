//
//  LabelExtentionTests.swift
//  MoviesTests
//
//  Created by mac on 6/17/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import XCTest

@testable import Movies

class LabelExtentionTests: XCTestCase {

    let sut = UILabel.init()
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testEnglishContentAlignment() {
        let text = "instabug"
        sut.text = text
        sut.decideTextDirection()
        XCTAssert(sut.textAlignment == .left)
    }
    
    func testArabicContentAlignment() {
        let text = "الرهينه"
        sut.text = text
        sut.decideTextDirection()
        XCTAssert(sut.textAlignment == .right)
    }

}
