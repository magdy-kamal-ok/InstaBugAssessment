//
//  CustomImageView.swift
//  Movies
//
//  Created by mac on 6/12/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import UIKit

let imageCash = NSCache<AnyObject, AnyObject>()
class CustomImageView: UIImageView
{
    var imageUrlString:String?
    func loadImageUsingUrlString(urlString:String, placeHolderImage:UIImage?)
    {
        self.image = placeHolderImage
        let url = NSURL(string: urlString)
        imageUrlString = urlString
        
        if let imageFromCash = imageCash.object(forKey: urlString as AnyObject) as? UIImage
        {
            self.image = imageFromCash
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
                if let imageToCashe = UIImage(data: data!) {
                    
                    imageCash.setObject(imageCash, forKey: urlString as AnyObject)
                    if self.imageUrlString == urlString {
                        self.image = imageToCashe
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

