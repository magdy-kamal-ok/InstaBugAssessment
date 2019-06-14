//
//  StringExtension.swift
//  Movies
//
//  Created by mac on 6/14/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
