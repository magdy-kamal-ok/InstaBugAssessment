//
//  CustomImageView.swift
//  Movies
//
//  Created by mac on 6/12/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import UIKit

fileprivate let imageCache = NSCache<AnyObject, AnyObject>()
class CustomImageView: UIImageView
{
    var imageUrlString:String?
    func loadImageUsingUrlString(urlString:String, placeHolderImage:UIImage?)
    {
        self.image = placeHolderImage
        let url = NSURL(string: urlString)
        imageUrlString = urlString
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage
        {
            self.image = imageFromCache
            return
            
        }
        URLSession.shared.dataTask(with: url! as URL) { (data, response, error) in
            
            if error != nil {
                DispatchQueue.main.async {
                    self.image = placeHolderImage
                }
                return
            }
            DispatchQueue.main.async(execute: {
                if let imageToCache = UIImage(data: data!) {
                    
                    imageCache.setObject(imageCache, forKey: urlString as AnyObject)
                    if self.imageUrlString == urlString {
                        self.image = imageToCache
                        }
                    
                }
                else
                {
                     self.image = placeHolderImage
                }
            })
            }.resume()
        
    }
}

