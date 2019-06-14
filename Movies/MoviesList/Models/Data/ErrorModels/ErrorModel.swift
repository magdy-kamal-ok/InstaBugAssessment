//
//  ErrorModel.swift
//  Movies
//
//  Created by mac on 6/13/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation

public typealias Codable = Decodable & Encodable

struct ErrorModel : Codable{
    var code: Int
    var message: String
    
    
    init(code: Int, message: String) {
        self.code = code
        self.message = message
    }
}

extension ErrorModel {
    
    enum ErrorCodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case statusMessage = "status_message"

    }
    
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: ErrorCodingKeys.self)
        
        code = try values.decode(Int.self, forKey: .statusCode)
        message = try values.decode(String.self, forKey: .statusMessage)
    }
}
