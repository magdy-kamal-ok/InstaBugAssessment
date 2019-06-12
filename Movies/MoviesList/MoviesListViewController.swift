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

    override func setupCellNibName() {
        self.cellNibName = "MovieTableViewCell"
    }
    
    override func getCellHeight() -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func getCellsCount() -> Int {
        if let moviesCount =
            moviesViewModel?.allMoviesArray.count
        {
                return moviesCount
        }
        return 0
    }
    override func getCustomCell(_ tableView: UITableView, customCell: UITableViewCell, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movieTableViewCell = customCell as! MovieTableViewCell
        let movie = self.moviesViewModel?.allMoviesArray[indexPath.row] as! Movie
        movieTableViewCell.configureCell(movie: movie)
        return movieTableViewCell
    }
    
    override func handlePaginationRequest() {
        showLoadingMoreHeader()
        self.moviesViewModel?.loadMoreMovies()
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
