//
//  MoviesListViewController.swift
//  Movies
//
//  Created by mac on 6/12/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import UIKit

class MoviesListViewController: BaseMoviesListViewController {
    // MARK: Parameters
    var moviesViewModel:MoviesViewModel?
    // MARK: ViewController lifeCycle
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
        self.title = Constants.MOVIES_LIST_TITLE.localized
    }
    // MARK: override required methods needed from parent class
    override func setupCellNibName() {
        self.cellNibName = "MovieTableViewCell"
    }
    
    override func getCellHeight() -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func getCellsCount(with section:Int) -> Int {
        
        let sectionType = self.moviesViewModel!.moviesSections[section]
        
        switch sectionType {
        case .myMovies:
            return myMoviesArray.count
        case .allMovies:
            return moviesViewModel?.allMoviesArray.count ?? 0
        }
    
    }
    
    override func getSectionsCount() -> Int {
        return self.moviesViewModel?.getSectionsCount() ?? 0
    }
    
    override func getSectionTitle(with section: Int) -> String {
        let sectionType = self.moviesViewModel!.moviesSections[section]
        switch sectionType {
        case .myMovies:
            return Constants.MY_MOVIES.localized
        case .allMovies:
            return Constants.ALL_MOVIES.localized
        }
    }
    
    override func getCustomCell(_ tableView: UITableView, customCell: UITableViewCell, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movieTableViewCell = customCell as! MovieTableViewCell
        var movie:Movie?
        let sectionType = self.moviesViewModel!.moviesSections[indexPath.section] 
            switch sectionType {
            case .myMovies:
                movie = myMoviesArray[indexPath.row] as? Movie
                movieTableViewCell.configureLocalMovieCell(movie: movie!)
            case .allMovies:
                movie = self.moviesViewModel?.allMoviesArray[indexPath.row] as? Movie
                movieTableViewCell.configureCell(movie: movie!)
            }
       
        return movieTableViewCell
    }
    
    override func handlePaginationRequest() {
        let totalListCount = (self.moviesViewModel?.listTotalCount)!
        let currentListCount = (self.moviesViewModel?.allMoviesArray.count)!
        if currentListCount < totalListCount && !(self.moviesViewModel?.isLoadingMore)!
        {
            showLoadingMoreView()
            self.moviesViewModel?.loadMoreMovies()
        }
    }
    
    override func swipeRefreshTableView() {
        self.moviesViewModel?.refreshMoviesList()
        
    }
    override func handleOpenAddNewMoview() {
        DispatchQueue.main.async {
            let newMovieViewController = NewMovieViewController.init(nibName: "NewMovieViewController", bundle: nil)
            self.navigationController?.pushViewController(newMovieViewController, animated: true)
        }

    }
}
extension MoviesListViewController:MovieViewControllerDelegate
{
    func showAlert(alert: UIAlertController) {
        self.present(alert, animated: true, completion: nil)
    }
    
    func refreshMoviesFinished() {
        self.checkRefreshControlState()
    }
    
    func loadingMoreMoviesFinished() {
        DispatchQueue.main.async {
            self.removeLoadingMoreView()
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
