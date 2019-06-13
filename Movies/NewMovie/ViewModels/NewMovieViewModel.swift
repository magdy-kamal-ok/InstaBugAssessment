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
        let movie = Movie.init(title: movieTitle, overview: movieOverView, releaseDate: date, image: self.selectedImage)
        myMoviesArray.add(movie)
    }
}
