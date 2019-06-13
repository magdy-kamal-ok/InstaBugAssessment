//
//  File.swift
//  Movies
//
//  Created by mac on 6/12/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//
import Foundation


protocol MovieViewControllerDelegate: NSObjectProtocol {
    
    func showLoader(flag:Bool)
    func refreshMoviesFinished()
    func loadingMoreMoviesFinished()
    func reloadMoviesData()
    
}

class MoviesViewModel: NSObject {
    
    //
    //MARK: Parameters
    //
    lazy private var backendManager = MoviesBackendManager()
    private var currentOffset: Int = 1
    public private(set) var listTotalCount: Int = 60
    public private(set) var allMoviesArray: NSMutableArray = []
    public private(set) var isLoadingMore: Bool = false
    private var isSwipeAndRefresh : Bool = false
    weak var movieViewControllerDelegate:MovieViewControllerDelegate?
    
    //
    // MARK: Initializer
    //
    override init() {
        super.init()
    }
    convenience init(delegate:MovieViewControllerDelegate) {
        self.init()
        self.movieViewControllerDelegate = delegate
    }
    
    //
    //MARK: Network Request
    //
    public func getMoviesData() {
        let requiredOffset = String(self.currentOffset)
        backendManager.getMovies(delegate: self, offset: requiredOffset)
    }
    //
    // MARK: Cancel Network Request
    //
    
    func cancelCoursesDatatRequest() {
        backendManager.cancelMoviesDatatRequest()
    }
    
    public func getSectionsCount()->Int
    {
        if myMoviesArray.count > 0
        {
            return 2
        }
        return 1
    }
    
    public func refreshMoviesList()
    {
        self.isSwipeAndRefresh = true
        self.currentOffset = 1
        self.getMoviesData()
    }
    public func loadMoreMovies()
    {
        self.isLoadingMore = true
        self.currentOffset += 1
        self.getMoviesData()
    }

    private func setViewsStates()
    {
        if self.isSwipeAndRefresh
        {
            self.isSwipeAndRefresh = false
            movieViewControllerDelegate?.refreshMoviesFinished()
        }
        else if self.isLoadingMore
        {
            self.isLoadingMore = false
            movieViewControllerDelegate?.loadingMoreMoviesFinished()
        }
        movieViewControllerDelegate?.reloadMoviesData()
    }
}
extension MoviesViewModel:MovieRequestDelegate
{
    func requestWillSend() {
        
        movieViewControllerDelegate?.showLoader(flag: true)
    }
    
    func requestSucceeded(data: MovieResponseModel?) {
        movieViewControllerDelegate?.showLoader(flag: false)

        if self.isSwipeAndRefresh
        {
            self.allMoviesArray.removeAllObjects()
        }
        if let moviesResponse = data
        {
            //self.listTotalCount = moviesResponse.numberOfResults
            
            self.allMoviesArray.addObjects(from: moviesResponse.movies)
        }
        setViewsStates()
    }
    
    func requestFailed(error:ErrorModel?) {
        self.isSwipeAndRefresh = false
        movieViewControllerDelegate?.refreshMoviesFinished()
        self.isLoadingMore = false
        movieViewControllerDelegate?.loadingMoreMoviesFinished()
    
    }
    
}
