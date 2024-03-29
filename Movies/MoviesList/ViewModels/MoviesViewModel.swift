//
//  MoviesViewModel.swift
//  Movies
//
//  Created by mac on 6/12/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//
import Foundation
import UIKit

enum MoviesSection {
    case myMovies
    case allMovies
}

protocol MovieViewControllerDelegate: NSObjectProtocol {
    
    func showLoader(flag:Bool)
    func refreshMoviesFinished()
    func loadingMoreMoviesFinished()
    func reloadMoviesData()
    func showAlert(alert:UIAlertController)
}

class MoviesViewModel: NSObject {
    
    //
    //MARK: Parameters
    //
    lazy private var backendManager = MoviesBackendManager()
    public private(set) var currentOffset: Int = 1
    public private(set) var listTotalCount: Int = 0
    public private(set) var allMoviesArray: NSMutableArray = []
    public private(set) var isLoadingMore: Bool = false
    public private(set) var isSwipeAndRefresh : Bool = false
    weak var movieViewControllerDelegate:MovieViewControllerDelegate?
    public private(set) var moviesSections = [MoviesSection]()
    private var maximumPageNumber = Constants.MAXIMUM_PAGE_COUNT
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
        if Reachability.isConnectedToNetwork()
        {
            let requiredOffset = String(self.currentOffset)
            backendManager.getMovies(delegate: self, offset: requiredOffset)
        }
        else
        {
            self.showNoInternetConnection()
        }
    }
    //
    // MARK: Cancel Network Request
    //
    
    func cancelMoviesDatatRequest() {
        backendManager.cancelMoviesDatatRequest()
    }
    
    public func getSectionsCount()->Int
    {
        self.moviesSections.removeAll()
        if myMoviesArray.count > 0
        {
            self.moviesSections.append(MoviesSection.myMovies)
        }
        if self.allMoviesArray.count > 0
        {
            self.moviesSections.append(MoviesSection.allMovies)
        }
        return self.moviesSections.count
    }
    
    public func refreshMoviesList()
    {
        self.isSwipeAndRefresh = true
        self.currentOffset = 1
        self.getMoviesData()
    }
    public func loadMoreMovies()
    {
        if currentOffset < self.maximumPageNumber
        {
            self.isLoadingMore = true
            self.currentOffset += 1
            self.getMoviesData()
        }
        else
        {
            stopLoadingMore()
        }
    }

    private func setViewsStates()
    {
        if self.isSwipeAndRefresh
        {
            stopRefreshing()
        }
        else if self.isLoadingMore
        {
            stopLoadingMore()
        }
        movieViewControllerDelegate?.reloadMoviesData()
    }
    private func stopLoadingMore()
    {
        self.isLoadingMore = false
        movieViewControllerDelegate?.loadingMoreMoviesFinished()
    }
    private func stopRefreshing()
    {
        self.isSwipeAndRefresh = false
        movieViewControllerDelegate?.refreshMoviesFinished()
    }
    
    private func showAlertMessage(message:String)
    {
        let alert = UIAlertController(title: Constants.ERROR.localized, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: Constants.RETRY.localized, style: UIAlertAction.Style.default, handler: { (action) in
            self.getMoviesData()
        }))
        alert.addAction(UIAlertAction(title: Constants.CANCEL.localized, style: UIAlertAction.Style.cancel, handler: { (action) in
            self.cancelMoviesDatatRequest()
        }))
        
        movieViewControllerDelegate?.showAlert(alert: alert)
    }
    
    private func showNoInternetConnection()
    
    {
        let alert = UIAlertController(title: Constants.WRANING.localized, message: Constants.INTERNET_CONNECTION.localized, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: Constants.OK.localized, style: UIAlertAction.Style.default, handler: { (action) in
                self.stopAllLoaders()
        }))
        
        movieViewControllerDelegate?.showAlert(alert: alert)
    }
    
    private func stopAllLoaders()
    {
        movieViewControllerDelegate?.showLoader(flag: false)
        self.stopRefreshing()
        self.stopLoadingMore()
    }
    
}
// MARK: movies request delegate

extension MoviesViewModel:MovieRequestDelegate
{
    
    func requestWillSend() {
        
        if !self.isLoadingMore && !self.isSwipeAndRefresh
        {
            movieViewControllerDelegate?.showLoader(flag: true)
        }
       
    }
    
    func requestSucceeded(data: MovieResponseModel?) {
        movieViewControllerDelegate?.showLoader(flag: false)

        if self.isSwipeAndRefresh
        {
            self.allMoviesArray.removeAllObjects()
        }
        if let moviesResponse = data
        {
            self.listTotalCount = moviesResponse.numberOfResults
            self.allMoviesArray.addObjects(from: moviesResponse.movies)
        }
        setViewsStates()
    }
    
    func requestFailed(error:ErrorModel?) {
        self.isSwipeAndRefresh = false
        movieViewControllerDelegate?.refreshMoviesFinished()
        self.isLoadingMore = false
        movieViewControllerDelegate?.loadingMoreMoviesFinished()
        movieViewControllerDelegate?.showLoader(flag: false)
        showAlertMessage(message: (error?.message)!)
    
    }
    
}
