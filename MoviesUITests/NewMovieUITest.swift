//
//  NewMovieUITest.swift
//  MoviesUITests
//
//  Created by mac on 6/15/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import XCTest
@testable import Movies

class NewMovieUITest: XCTestCase {
    var app:XCUIApplication!
    override func setUp() {
        super.setUp()
        app = XCUIApplication()
    }
    
    override func tearDown() {
        app = nil
        super.tearDown()
    }

    func testOpenGallery()
    {
        app.launch()
        let newBtn = app.buttons[Constants.ADD_NEW_VIDEO_BTN_IDENTIFIER]
        newBtn.tap()
        let addBtn = app.buttons[Constants.NEW_MOVIE_ADD_BTN_IDENTIFIER]
        addBtn.tap()
        let tableView = app.tables.firstMatch
        let firstCell = tableView.cells.element(boundBy: 0)
        firstCell.tap()
        XCTAssert(app.navigationBars["Moments"].exists)
//        let collection = app.collectionViews.firstMatch
//        let firstCellImage = collection.cells.element(boundBy: 0)
//        firstCellImage.tap()
        
    }
    func testOpenNewVideoViewController() {
        app.launch()
        let newBtn = app.buttons[Constants.ADD_NEW_VIDEO_BTN_IDENTIFIER]
        newBtn.tap()
        let navBarTitle = app.navigationBars.firstMatch
        XCTAssert(navBarTitle.identifier == "New Movie")
    }

    func testNewMovieValidation() {
        app.launch()
        let newBtn = app.buttons[Constants.ADD_NEW_VIDEO_BTN_IDENTIFIER]
        newBtn.tap()
        let doneBtn = app.buttons[Constants.NEW_MOVIE_DONE_BTN_IDENTIFIER]
        doneBtn.tap()
        let alert = app.alerts.firstMatch
        XCTAssert(alert.exists)
    }
    
    func testNewMovieResetBtn() {
        app.launch()
        let newBtn = app.buttons[Constants.ADD_NEW_VIDEO_BTN_IDENTIFIER]
        newBtn.tap()
        
        let titleTextField = app.textFields[Constants.NEW_MOVIE_TITLE_IDENTIFIER]
        titleTextField.tap()
        titleTextField.typeText("new local movie")
        dismissKeyBoard()
        let resetBtn = app.buttons[Constants.NEW_MOVIE_RESET_BTN_IDENTIFIER]
        resetBtn.tap()
        let textValue = titleTextField.value as! String
        XCTAssert(textValue.isEmpty)
    }
    
    func testAddNewMovieToList() {
        app.launch()
        let newBtn = app.buttons[Constants.ADD_NEW_VIDEO_BTN_IDENTIFIER]
        newBtn.tap()
        
        let titleTextField = app.textFields[Constants.NEW_MOVIE_TITLE_IDENTIFIER]
        titleTextField.tap()
        titleTextField.typeText("new local movie")
        dismissKeyBoard()
        let titleOverViewField = app.textViews[Constants.NEW_MOVIE_OVERVIEW_IDENTIFIER]
        titleOverViewField.tap()
        titleOverViewField.typeText("new local movie overview")
        dismissKeyBoard()
        let datePickers = app.datePickers[Constants.NEW_MOVIE_PICKER_IDENTIFIER]
        datePickers.pickerWheels.element(boundBy: 1).adjust(toPickerWheelValue: "21")
        let doneBtn = app.buttons[Constants.NEW_MOVIE_DONE_BTN_IDENTIFIER]
        doneBtn.tap()
        let moviesTableView = app.tables[Constants.TABLEVIEW_IDENTIFIER]
        XCTAssert(moviesTableView.cells.count == 21)
        let firstCell = moviesTableView.cells.element(boundBy: 0)
        let movieTitle = firstCell.staticTexts[Constants.MOVIE_TITLE_IDENTIFIER]
        let textValue = movieTitle.label 
        XCTAssert(textValue == "new local movie")
    }
    
    
}
extension NewMovieUITest
{
    func dismissKeyBoard()
    {
        let normalized = app.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))
        let coordinate = normalized.withOffset(CGVector(dx: 5, dy: 150))
        coordinate.tap()
    }
}
