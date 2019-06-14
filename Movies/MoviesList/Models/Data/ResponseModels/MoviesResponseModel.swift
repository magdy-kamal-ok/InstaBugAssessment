//
//  MoviesResponseModel.swift
//  Movies
//
//  Created by mac on 6/12/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation

struct MovieResponseModel {
    let page: Int
    let numberOfResults: Int
    let numberOfPages: Int
    let movies: [Movie]
}

extension MovieResponseModel: Decodable {
    
    private enum MovieResponseCodingKeys: String, CodingKey {
        case page = "page"
        case numberOfResults = "total_results"
        case numberOfPages = "total_pages"
        case movies = "results"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: MovieResponseCodingKeys.self)
        
        page = try values.decode(Int.self, forKey: .page)
        numberOfResults = try values.decode(Int.self, forKey: .numberOfResults)
        numberOfPages = try values.decode(Int.self, forKey: .numberOfPages)
        movies = try values.decode([Movie].self, forKey: .movies)
        
    }
}



