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
    
    func requestFailed(error: ErrorModel?)
}

class MoviesRequest: BaseMovieRequest<MovieResponseModel, ErrorModel> {
    
    weak var delegate: MovieRequestDelegate?
    
    public override init() {
        super.init()
    }
    
    public func getMoviesData(offset:String){
        delegate?.requestWillSend()
        let apiUrl = Constants.API_URL+"\(offset)"
        getMoviesRequsetData(from: apiUrl)
    }
    
    
    override func onRequestSuccess(data: MovieResponseModel?) {
        delegate?.requestSucceeded(data: data)
    }
    override func onRequestFail(error: ErrorModel?) {
        delegate?.requestFailed(error: error)
    }

    
}
