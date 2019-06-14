//
//  NewMovieViewModel.swift
//  Movies
//
//  Created by mac on 6/13/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation
import UIKit

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
        self.validateNewMovieData(movieTitle: movieTitle, movieOverView: movieOverView)
        
    }
    
    func validateNewMovieData(movieTitle:String, movieOverView:String)
    {
        if movieTitle.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
            self.showAlertMessage(message: "emptyTitleMsg".localized)
        }
        else if movieOverView.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
            self.showAlertMessage(message: "emptyOverViewMsg".localized)

        }
        else
        {
            addMovieTotheList(movieTitle: movieTitle, movieOverView: movieOverView)
        }
    }
    
    func addMovieTotheList(movieTitle:String, movieOverView:String)
    {
        let date = self.selectedDate ?? Date()
        let dateStr = HelperDateFormatter.formatDateAsDashed(date: date)
        let movieImage = self.selectedImage ?? UIImage.init(named: "ic_movie_iphone_placeholder")!
        let movie = Movie.init(title: movieTitle, overview: movieOverView, releaseDate: dateStr, image: movieImage)
        myMoviesArray.add(movie)
    }
    func showAlertMessage(message:String)
    {
        let alert = UIAlertController(title: "alert".localized, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "ok".localized, style: UIAlertAction.Style.default, handler: nil))
        delegate?.showAlert(alert: alert)
    }
}
