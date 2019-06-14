//
//  MovieModel.swift
//  Movies
//
//  Created by mac on 6/12/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation
import UIKit

struct Movie {
    var id: Int? = 0
    var posterPath: String = ""
    let title: String
    let releaseDate: String
    let overview: String
    var image:UIImage?
    

    init(title: String, overview: String, releaseDate: String, image:UIImage)
    {
        self.title = title
        self.releaseDate = releaseDate
        self.overview = overview
        self.image = image
    }
}

extension Movie: Decodable {
    
    enum MovieCodingKeys: String, CodingKey {
        case id         = "id"
        case posterPath = "poster_path"
        case title      = "title"
        case releaseDate = "release_date"
        case overview    = "overview"
    }
    
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: MovieCodingKeys.self)
        
        id = try values.decode(Int.self, forKey: .id)
        posterPath = try values.decode(String.self, forKey: .posterPath)
        title = try values.decode(String.self, forKey: .title)
        releaseDate = try values.decode(String.self, forKey: .releaseDate)
        overview = try values.decode(String.self, forKey: .overview)
    }
}
