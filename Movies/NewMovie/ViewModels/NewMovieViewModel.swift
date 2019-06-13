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

class NewMovieViewModel: NSObject {
    
    //
    //MARK: Parameters
    //
    var selectedImage:UIImage?
    var selectedDate:Date?

    
    //
    // MARK: Initializer
    //
    override init() {
        super.init()
    }
    
    func createNewMovie(movieTitle:String, movieOverView:String)
    {
        
        let date = self.selectedDate?.description ?? Date().description
        let dateStr = HelperDateFormatter.formatDate(dateString: date)
        let movie = Movie.init(title: movieTitle, overview: movieOverView, releaseDate: dateStr, image: self.selectedImage ?? UIImage.init(named: "ic_movie_iphone_placeholder")!)
        myMoviesArray.add(movie)
    }
}
