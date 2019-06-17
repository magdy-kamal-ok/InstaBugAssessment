//
//  NewMovieViewModel.swift
//  Movies
//
//  Created by mac on 6/13/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation
import UIKit

// MARK: gloabal array that contains my local movies saved per session
var myMoviesArray: NSMutableArray = []

protocol NewMovieViewControllerDelegate: NSObjectProtocol {
    
    func showAlert(alert:UIAlertController)
}

class NewMovieViewModel: NSObject {
    
    //
    //MARK: Parameters
    //
    var selectedImage:UIImage?
    var selectedDate:Date?
    weak var delegate:NewMovieViewControllerDelegate?
    
    //
    // MARK: Initializer
    //
    override init() {
        super.init()
    }
    
    // MARK: Create new movie
    func createNewMovie(movieTitle:String, movieOverView:String)
    {
        if self.checkValidation(movieTitle: movieTitle, movieOverView: movieOverView)
        {
            addMovieTotheList(movieTitle: movieTitle, movieOverView: movieOverView)
        }
        else
        {
            self.showValidationAlert(movieTitle: movieTitle, movieOverView: movieOverView)
        }
    }

    private func showValidationAlert(movieTitle:String, movieOverView:String)
    {
        if movieTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        {
            self.showAlertMessage(with: Constants.EMPTY_TITLE_MSG.localized)
        }
        else if movieOverView.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        {
            self.showAlertMessage(with: Constants.EMPTY_OVERVIEW_MSG.localized)

        }
    }
    
    func checkValidation(movieTitle:String, movieOverView:String)->Bool
    {
        if movieTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        {
            return false
        }
        else if movieOverView.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        {
            return false
            
        }
        return true
    }
    private func addMovieTotheList(movieTitle:String, movieOverView:String)
    {
        let date = self.selectedDate ?? Date()
        let dateStr = HelperDateFormatter.formatDate(date: date, format: Constants.YEAR_MONTH_DAY_FORMAT)
        let movieImage = self.selectedImage ?? UIImage.init(named: Constants.IMAGE_PLACEHOLDER_NAME)!
        let movie = Movie.init(title: movieTitle, overview: movieOverView, releaseDate: dateStr, image: movieImage)
        myMoviesArray.add(movie)
    }
    private func showAlertMessage(with message:String)
    {
        let alert = UIAlertController(title: Constants.ALERT.localized, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: Constants.OK.localized, style: UIAlertAction.Style.default, handler: nil))
        delegate?.showAlert(alert: alert)
    }
}
