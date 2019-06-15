//
//  NewMovieViewModelTests.swift
//  MoviesTests
//
//  Created by mac on 6/15/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import XCTest
@testable import Movies

class NewMovieViewModelTests: XCTestCase {
    
    var sut:NewMovieViewModel!
    override func setUp() {
        sut = NewMovieViewModel()
    }

    override func tearDown() {
        sut = nil
    }

    func testNewMovieFullValidation() {
        let movieTitle = "new movie"
        let movieOverView = "movie overview"
        XCTAssert(sut.checkValidation(movieTitle: movieTitle, movieOverView: movieOverView))
    }
    func testNewMovieEmptyValidation() {
        let movieTitle = "\n"
        let movieOverView = " "
        XCTAssertNotEqual(sut.checkValidation(movieTitle: movieTitle, movieOverView: movieOverView), true)
    }
    
    func testAddNewMovieToMyMovies() {
        let movieTitle = "new movie"
        let movieOverView = "movie overview"
        sut.createNewMovie(movieTitle: movieTitle, movieOverView: movieOverView)
        XCTAssert(myMoviesArray.count == 1)
    }

}
