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
    
    func testDecodingMoviesRepsponse()
    {
        let moviesBundle = Bundle(for: type(of: self))
        let path = moviesBundle.path(forResource: "movies", ofType: "json")
        let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
        do
        {
            let response = try JSONDecoder().decode(MovieResponseModel.self, from: data!)
            XCTAssert(response.movies.count==20)
        }
        catch{
            XCTFail()
        }
    }
    
    func testPhotoDownloaded_ImageOrientation()
    {
        let expectedImageOrientation = UIImage.init(named: "testImage")?.imageOrientation
        guard let url = URL(string: Constants.IMAGE_TEST_URL) else {
            XCTFail()
            return
        }
        let sessionExpectation = expectation(description: "session")
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error
            {
                XCTFail(error.localizedDescription)
            }
            if let data = data{
                guard let image = UIImage(data: data) else {
                    XCTFail()
                    return
                }
                sessionExpectation.fulfill()
                XCTAssertEqual(image.imageOrientation, expectedImageOrientation)
            }
        }.resume()
        
        waitForExpectations(timeout: 15, handler: nil)
    }

}
