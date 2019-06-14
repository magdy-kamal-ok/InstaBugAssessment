//
//  MovieTableViewCell.swift
//  Movies
//
//  Created by mac on 6/12/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    // MARK: outlets
    @IBOutlet weak var posterImageView: CustomImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var overViewLbl: UILabel!
    // MARK: Parameters
    var imageTapGesture = UITapGestureRecognizer()
    var zoomImageView:UIImageView?
    var startingFrame:CGRect?
    var blackBackgroundView:UIView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
        // Configure the view for the selected state
    }
    
    func configureLocalMovieCell(movie:Movie)
    {
        setCellData(movie: movie)
        self.posterImageView.image = movie.image
        
    }
    func configureCell(movie:Movie)
    {
        setCellData(movie: movie)
        let url = Constants.BASE_IMAGE_URL + movie.posterPath
        self.posterImageView.loadImageUsingUrlString(urlString: url, placeHolderImage: UIImage.init(named: Constants.IMAGE_PLACEHOLDER_NAME))
        
    }
    
    private func setCellData(movie:Movie)
    {
        self.titleLbl.text = movie.title
        self.titleLbl.decideTextDirection()
        self.dateLbl.text = HelperDateFormatter.formatDate(date: HelperDateFormatter.getDateFromString(dateString: movie.releaseDate, format: Constants.YEAR_MONTH_DAY_FORMAT), format: Constants.SHORTMONTH_DAY_YEAR_FORMAT)
        self.overViewLbl.text = movie.overview
        self.overViewLbl.decideTextDirection()
        setImagesControl()
    }
    private func setImageViewsAccessibility()
    {
        self.posterImageView.accessibilityIdentifier = Constants.POSTER_IMAGE_VIEW_IDENTIFIER
    }
    fileprivate func setImagesControl(){
       
        self.posterImageView.isUserInteractionEnabled = true
        self.imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleZoomTap(_:)))
        self.posterImageView.addGestureRecognizer(self.imageTapGesture)
        self.setImageViewsAccessibility()
    }
    
    @objc func handleZoomTap(_ sender: UITapGestureRecognizer)
    {
        
        if let imageView = imageTapGesture.view as? UIImageView
        {
            self.performZoomInForStartingImageView(startingImageView: imageView)
        }
    }
    func performZoomInForStartingImageView(startingImageView:UIImageView)
    {
        self.zoomImageView = startingImageView
        self.zoomImageView?.accessibilityIdentifier = Constants.ZOOM_POSTER_IMAGE_IDENTIFIER

        startingFrame = startingImageView.superview?.convert(startingImageView.frame, to: nil)
        let zoomingImageView = UIImageView(frame: startingFrame!)
        zoomingImageView.image = startingImageView.image
        zoomingImageView.isUserInteractionEnabled = true
        zoomingImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleZoomOutTap)))
        if let keyWindow = UIApplication.shared.keyWindow
        {
            blackBackgroundView = UIView(frame: keyWindow.frame)
            blackBackgroundView?.alpha = 0
            blackBackgroundView?.backgroundColor = UIColor.black
            keyWindow.addSubview(blackBackgroundView!)
            keyWindow.addSubview(zoomingImageView)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                
                self.blackBackgroundView?.alpha = 1
                let height = (self.startingFrame?.height)! / (self.startingFrame?.width)! * keyWindow.frame.width
                zoomingImageView.frame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height)
                zoomingImageView.center = keyWindow.center
                
            }, completion: nil)
            
        }
    }
    
    @objc func handleZoomOutTap(tapGesture:UITapGestureRecognizer)
    {
        if let zoomOutImageView = tapGesture.view as? UIImageView{
            zoomOutImageView.layer.cornerRadius = 16
            zoomOutImageView.layer.masksToBounds = true
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                
                zoomOutImageView.frame = self.startingFrame!
                self.blackBackgroundView?.alpha = 0
            }, completion: { (completed:Bool) in
                zoomOutImageView.removeFromSuperview()
            })
            
        }
    }
}
