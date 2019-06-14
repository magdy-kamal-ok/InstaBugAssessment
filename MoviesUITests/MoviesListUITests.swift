//
//  MoviesListUITests.swift
//  MoviesListUITests
//
//  Created by mac on 6/12/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import XCTest
@testable import Movies

class MoviesListUITests: XCTestCase {

    var app:XCUIApplication!
    override func setUp() {
        super.setUp()
        app = XCUIApplication()
    }

    override func tearDown() {
        app = nil
        super.tearDown()
    }

    func testMoviesListLoaded_Example() {
        app.launch()
        let tableView = app.tables[Constants.TABLEVIEW_IDENTIFIER]
        let count = tableView.cells.count
        XCTAssert(count == 20)
        
    }
    
    func testMoviesListLoadMore_Example() {
        app.launch()
        let tableView = app.tables[Constants.TABLEVIEW_IDENTIFIER]
        let lastCell = tableView.cells.element(boundBy: 19)
         tableView.scrollToElement(element: lastCell)
        let start = lastCell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))
        let finish = lastCell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: -10))

        start.press(forDuration: 0, thenDragTo: finish)
        let loadMore = app.activityIndicators[Constants.Load_More_INDICATOR_IDENTIFIER]
        XCTAssert(loadMore.exists)
        
       
    }
    
    func testMoviesListPullRefresh_Example() {
        app.launch()
        let tableView = app.tables[Constants.TABLEVIEW_IDENTIFIER]
        
        let firstCell = tableView.cells.element(boundBy: 0)
        let start = firstCell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))
        let finish = firstCell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 5))
        start.press(forDuration: 0, thenDragTo: finish)
        _ = app.waitForExistence(timeout: 5)
        XCTAssert(tableView.cells.count == 20)
        
    }
    
    func testMovieImageExists_Example() {
        app.launch()
        let tableView = app.tables[Constants.TABLEVIEW_IDENTIFIER]
        let firstCell = tableView.cells.element(boundBy: 0)
        let posterImage = firstCell.images[Constants.POSTER_IMAGE_VIEW_IDENTIFIER]
        XCTAssert(posterImage.exists)
    }
    
    func testMovieTitleExists_Example() {
        app.launch()
        let tableView = app.tables[Constants.TABLEVIEW_IDENTIFIER]
        let firstCell = tableView.cells.element(boundBy: 0)
        let movieTitle = firstCell.staticTexts[Constants.MOVIE_TITLE_IDENTIFIER]
        XCTAssert(movieTitle.exists)
    }
    func testMovieOverViewExists_Example() {
        app.launch()
        let tableView = app.tables[Constants.TABLEVIEW_IDENTIFIER]
        let firstCell = tableView.cells.element(boundBy: 0)
        let movieOverView = firstCell.staticTexts[Constants.MOVIE_OVERVIEW_IDENTIFIER]
        XCTAssert(movieOverView.exists)
    }
    func testMovieDateExists_Example() {
        app.launch()
        let tableView = app.tables[Constants.TABLEVIEW_IDENTIFIER]
        let firstCell = tableView.cells.element(boundBy: 0)
        let movieDate = firstCell.staticTexts[Constants.MOVIE_DATE_IDENTIFIER]
        XCTAssert(movieDate.exists)
    }
    
    func testMovieZoomInImage_Example() {
        app.launch()
        let tableView = app.tables[Constants.TABLEVIEW_IDENTIFIER]
        let firstCell = tableView.cells.element(boundBy: 0)
        let posterImage = firstCell.images[Constants.POSTER_IMAGE_VIEW_IDENTIFIER]
        posterImage.tap()
        let zoomImage = app.images[Constants.ZOOM_POSTER_IMAGE_IDENTIFIER]
        XCTAssert(zoomImage.exists)
    }
    func testMovieZoomInOutImage_Example() {
        app.launch()
        let tableView = app.tables[Constants.TABLEVIEW_IDENTIFIER]
        let firstCell = tableView.cells.element(boundBy: 0)
        let posterImage = firstCell.images[Constants.POSTER_IMAGE_VIEW_IDENTIFIER]
        posterImage.tap()
        let zoomImage = app.images[Constants.ZOOM_POSTER_IMAGE_IDENTIFIER]
        zoomImage.tap()
        XCTAssert(posterImage.exists)
    }
    
    func testOpenNewVideo_Example() {
        app.launch()
        let newBtn = app.buttons[Constants.ADD_NEW_VIDEO_BTN_IDENTIFIER]
        newBtn.tap()
    }
    

}
extension XCUIElement {
    func scrollToElement(element: XCUIElement) {
        while !element.visible() {
            swipeUp()
        }
    }
    
    func visible() -> Bool {
        guard self.exists && !self.frame.isEmpty else { return false }
        return XCUIApplication().windows.element(boundBy: 0).frame.contains(self.frame)
    }
}
