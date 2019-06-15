//
//  MoviesViewModelTests.swift
//  MoviesTests
//
//  Created by mac on 6/15/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import XCTest

@testable import Movies

class MoviesViewModelTests: XCTestCase {
    
    var sut:MoviesViewModel!
    override func setUp() {
        sut = MoviesViewModel()
    }

    override func tearDown() {
        sut = nil
    }

    func testInitialParamertesValues() {
        XCTAssert(sut.currentOffset == 1)
        XCTAssert(sut.isLoadingMore == false)
        XCTAssert(sut.isSwipeAndRefresh == false)
    }
    
    
    func testParametersValuesAfterRefreshCall()
    {
        sut.refreshMoviesList()
        XCTAssert(sut.currentOffset == 1)
        XCTAssert(sut.isSwipeAndRefresh == true)
    }
    
    func testParametersValuesLoadMoreCall()
    {
        sut.loadMoreMovies()
        XCTAssert(sut.currentOffset == 2)
        XCTAssert(sut.isLoadingMore == true)
    }

}
