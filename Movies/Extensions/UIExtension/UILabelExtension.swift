//
//  UILabelExtension.swift
//  Movies
//
//  Created by mac on 6/14/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import UIKit

extension UILabel {
    func decideTextDirection () {
        let tagScheme = [NSLinguisticTagScheme.language]
        let tagger    = NSLinguisticTagger(tagSchemes: tagScheme, options: 0)
        tagger.string = self.text
        let lang      = tagger.tag(at: 0, scheme: NSLinguisticTagScheme.language,
                                   tokenRange: nil, sentenceRange: nil)
        if lang?.rawValue.range(of: "he") != nil ||  lang?.rawValue.range(of: "ar") != nil {
            self.textAlignment = NSTextAlignment.right
        } else {
            self.textAlignment = NSTextAlignment.left
        }
    }
}
