//
//  Constants.swift
//  Movies
//
//  Created by mac on 6/12/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation

class Constants: NSObject {
    
    // MARK: Request Constants
    private static let BASE_URL = "https://api.themoviedb.org/"
    public static let BASE_IMAGE_URL = "https://image.tmdb.org/t/p/w500"
    public static let API_URL = Constants.BASE_URL + "3/discover/movie?api_key=acea91d2bff1c53e6604e4985b6989e2&page="
    
    // MARK: Maximun Pages Count
    public static let MAXIMUM_PAGE_COUNT = 1000
    // MARK: DateFormats Constants
    public static let YEAR_MONTH_DAY_FORMAT = "yyyy-MM-dd"
    public static let SHORTMONTH_DAY_YEAR_FORMAT = "MMM dd,yyyy"
    
    // MARK: Image name placeholder
    public static let IMAGE_PLACEHOLDER_NAME = "ic_movie_iphone_placeholder"
    
    // MARK: Localized Strings
    
    public static let CANCEL = "cancel"
    public static let RETRY = "retry"
    public static let ALERT = "alert"
    public static let ERROR = "error"
    public static let WRANING = "warning"
    public static let OK = "ok"
    public static let EMPTY_TITLE_MSG = "emptyTitleMsg"
    public static let EMPTY_OVERVIEW_MSG = "emptyOverViewMsg"
    public static let NEW_MOVIE_TITLE = "newMovie"
    public static let MOVIES_LIST_TITLE = "moviesList"
    public static let MY_MOVIES = "myMovies"
    public static let ALL_MOVIES = "allMovies"
    public static let INTERNET_CONNECTION = "networkConnectionMsg"
    
    
    // MARK: UITest accessability identifiers
    
    // movies list identifiers
    public static let TABLEVIEW_IDENTIFIER = "moviesListTableView"
    public static let ADD_NEW_VIDEO_BTN_IDENTIFIER = "AddMoview"
    public static let Load_More_INDICATOR_IDENTIFIER = "loadMore"
    public static let PULL_REFRESH_INDICATOR_IDENTIFIER = "pullRefresh"
    public static let LOADING_INDICATOR_IDENTIFIER = "loadIndicator"
    public static let POSTER_IMAGE_VIEW_IDENTIFIER = "posterImage"
    public static let ZOOM_POSTER_IMAGE_IDENTIFIER = "zoomPosterImage"
    public static let MOVIE_TITLE_IDENTIFIER = "movieTitle"
    public static let MOVIE_OVERVIEW_IDENTIFIER = "movieOverView"
    public static let MOVIE_DATE_IDENTIFIER = "movieDate"
    
    // new movie identifiers
    public static let NEW_POSTER_IMAGE_VIEW_IDENTIFIER = "newPosterImage"
    public static let NEW_MOVIE_TITLE_IDENTIFIER = "newMovieTitle"
    public static let NEW_MOVIE_OVERVIEW_IDENTIFIER = "newMovieOverView"
    public static let NEW_MOVIE_PICKER_IDENTIFIER = "newMovieDate"
    public static let NEW_MOVIE_ADD_BTN_IDENTIFIER = "newMovieAddBtn"
    public static let NEW_MOVIE_DONE_BTN_IDENTIFIER = "newMovieDoneBtn"
    public static let NEW_MOVIE_RESET_BTN_IDENTIFIER = "newMovieResetBtn"
    
    public static let IMAGE_TEST_URL = "https://image.tmdb.org/t/p/w500/xqR4ABkFTFYe8NDJi3knwWX7zfn.jpg"
}
