//
//  NewMovieViewController.swift
//  Movies
//
//  Created by mac on 6/12/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import UIKit

class NewMovieViewController: UIViewController {

    // MARK: outlets
    @IBOutlet weak var movieDatePicker: UIDatePicker!
    @IBOutlet weak var movieOverViewTextView: UITextView!
    @IBOutlet weak var movieTitlTextField: UITextField!
    @IBOutlet weak var posterImageView: UIImageView!
    
    // MARK: Parameters
    var imagePicker: UIImagePickerController!
    var selectedImage:UIImage?
    var newMovieViewModel  = NewMovieViewModel()
    
    // MARK: ViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        movieDatePicker.minimumDate = Date()
    }

    // MARK: viewController Actions
    @IBAction func resetBtnClicked(_ sender: UIButton) {
        
        self.newMovieViewModel.selectedImage = nil
        self.movieTitlTextField.text = ""
        self.movieOverViewTextView.text = ""
        self.movieDatePicker.date = Date()
    }
    
    @IBAction func doneBtnClicked(_ sender: UIButton) {
        
        self.newMovieViewModel.createNewMovie(movieTitle: self.movieTitlTextField.text!, movieOverView: self.movieOverViewTextView.text)
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func selectImageBtnClicked(_ sender: UIButton) {
        
        self.openGalleryView()
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        self.newMovieViewModel.selectedDate = sender.date
    }
}

extension NewMovieViewController
{
    func openGalleryView()
    {
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
}
extension NewMovieViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate
{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)

    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        self.newMovieViewModel.selectedImage = info[.originalImage] as? UIImage
        self.posterImageView.image = self.newMovieViewModel.selectedImage
    }

}
