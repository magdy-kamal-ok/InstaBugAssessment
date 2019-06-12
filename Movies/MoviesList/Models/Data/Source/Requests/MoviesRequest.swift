//
//  MoviesRequest.swift
//  Movies
//
//  Created by mac on 6/12/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation

protocol MovieRequestDelegate: NSObjectProtocol {
    
    func requestWillSend()
    
    func requestSucceeded(data: MovieResponseModel?)
    
    func requestFailed()
}

class MoviesRequest: BaseMovieRequest<MovieResponseModel> {
    
    weak var delegate: MovieRequestDelegate?
    
    public override init() {
        super.init()
    }
    
    public func getMoviesData(offset:String){
        delegate?.requestWillSend()
        getMoviesRequsetData(from: "http://api.themoviedb.org/3/discover/movie?api_key=acea91d2bff1c53e6604e4985b6989e2&page=\(offset)")
    }
    
    override func onRequestSuccess(data: MovieResponseModel?) {
        delegate?.requestSucceeded(data: data)
    }
    
    override func onRequestFail() {
        delegate?.requestFailed()
    }
    
    override func getHeaders() -> HTTPHeaders {
        return ["":""]
    }
}
