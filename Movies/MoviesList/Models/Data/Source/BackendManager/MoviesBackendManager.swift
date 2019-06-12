//
//  File.swift
//  Movies
//
//  Created by mac on 6/12/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import UIKit

class MoviesBackendManager: NSObject {
    
    
    lazy var moviesRequest = MoviesRequest()
    
    public func getMovies(delegate: MovieRequestDelegate, offset: String) {
        moviesRequest.delegate = delegate
        moviesRequest.getMoviesData(offset: offset)
    }
    func cancelMoviesDatatRequest() {
        moviesRequest.cancelRequest()
    }
}

