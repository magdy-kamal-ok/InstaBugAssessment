//
//  MoviesListViewController.swift
//  Movies
//
//  Created by mac on 6/12/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import UIKit

class MoviesListViewController: BaseMoviesListViewController {

    var moviesViewModel:MoviesViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPagination()
        setupSwipeRefresh()
        moviesViewModel = MoviesViewModel.init(delegate: self)
        moviesViewModel?.getMoviesData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.moviesTableView.reloadData()
    }
    
    override func setupCellNibName() {
        self.cellNibName = "MovieTableViewCell"
    }
    
    override func getCellHeight() -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func getCellsCount(with section:Int) -> Int {
        
        if getSectionsCount() > 1
        {
            if section == 0
            {
                return myMoviesArray.count
            }
            return moviesViewModel?.allMoviesArray.count ?? 0
        }
        else
        {
          return moviesViewModel?.allMoviesArray.count ?? 0
        }
    }
    
    override func getSectionsCount() -> Int {
        return self.moviesViewModel?.getSectionsCount() ?? 1
    }
    
    override func getSectionTitle(with section: Int) -> String {
        if getSectionsCount() > 1
        {
            if section == 0
            {
                return "My Movies"
            }
            return "All Movies"
        }
        else
        {
            return "All Movies"
        }
    }
    
    override func getCustomCell(_ tableView: UITableView, customCell: UITableViewCell, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movieTableViewCell = customCell as! MovieTableViewCell
        var movie:Movie?
        if  self.getSectionsCount() > 1
        {
            if indexPath.section == 0
            {
                movie = myMoviesArray[indexPath.row] as! Movie
                movieTableViewCell.configureLocalMovieCell(movie: movie!)
            }
            else
            {
                movie = self.moviesViewModel?.allMoviesArray[indexPath.row] as! Movie
                movieTableViewCell.configureCell(movie: movie!)

            }
        }
        else
        {
            movie = self.moviesViewModel?.allMoviesArray[indexPath.row] as! Movie
            movieTableViewCell.configureCell(movie: movie!)
        }
       
        return movieTableViewCell
    }
    
    override func handlePaginationRequest() {
        let totalListCount = (self.moviesViewModel?.listTotalCount)!
        let currentListCount = (self.moviesViewModel?.allMoviesArray.count)!
        if currentListCount < totalListCount && !(self.moviesViewModel?.isLoadingMore)!
        {
            showLoadingMoreHeader()
            self.moviesViewModel?.loadMoreMovies()
        }
    }
    
    override func swipeRefreshTableView() {
        self.moviesViewModel?.refreshMoviesList()
        
    }
    override func handleOpenAddNewMoview() {
        let newMovieViewController = NewMovieViewController.init(nibName: "NewMovieViewController", bundle: nil)
        self.navigationController?.pushViewController(newMovieViewController, animated: true)
    }
}
extension MoviesListViewController:MovieViewControllerDelegate
{
    func refreshMoviesFinished() {
        self.checkRefreshControlState()
    }
    
    func loadingMoreMoviesFinished() {
        DispatchQueue.main.async {
            self.removeLoadingMoreHeader()
        }
        
    }
    
    func showLoader(flag: Bool) {
        if flag
        {
            self.showProgressLoaderIndicator()
        }
        else
        {
            self.hideProgressLoaderIndicator()
        }
    }
    
    func reloadMoviesData() {
        //
        DispatchQueue.main.async {
          self.moviesTableView.reloadData()
        }
        
    }
    
    
    
}
