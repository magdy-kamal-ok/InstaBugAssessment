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
    @IBOutlet weak var resetBtn: UIButton!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var addImageBtn: UIButton!
    
    // MARK: Parameters
    var imagePicker: UIImagePickerController!
    var selectedImage:UIImage?
    var newMovieViewModel  = NewMovieViewModel()
    
    // MARK: ViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        resetDateForDatePicker()
        setTextOverViewTheme()
        setAccessibilityIdentifiers()
        newMovieViewModel.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = Constants.NEW_MOVIE_TITLE.localized

    }
    
    // MARK: viewController Actions
    @IBAction func resetBtnClicked(_ sender: UIButton) {
        
        self.newMovieViewModel.selectedImage = nil
        self.posterImageView.image = UIImage.init(named: Constants.IMAGE_PLACEHOLDER_NAME)!
        self.movieTitlTextField.text = ""
        self.movieOverViewTextView.text = ""
        resetDateForDatePicker()
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
// MARK: required functions
extension NewMovieViewController
{
    // MARK: open Image picker
    func openGalleryView()
    {
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    // MARK: set minimum date for selection
    func resetDateForDatePicker()
    {
        self.newMovieViewModel.selectedDate = Date()
    }
    func setTextOverViewTheme()
    {
        let borderColor = UIColor.lightGray
        movieOverViewTextView.layer.borderWidth = 0.5
        movieOverViewTextView.layer.borderColor = borderColor.cgColor
        movieOverViewTextView.layer.cornerRadius = 5.0
    }
    
    func setAccessibilityIdentifiers()
    {
        movieDatePicker.accessibilityIdentifier = Constants.NEW_MOVIE_PICKER_IDENTIFIER
        movieTitlTextField.accessibilityIdentifier = Constants.NEW_MOVIE_TITLE_IDENTIFIER
        movieOverViewTextView.accessibilityIdentifier = Constants.NEW_MOVIE_OVERVIEW_IDENTIFIER
        addImageBtn.accessibilityIdentifier = Constants.NEW_MOVIE_ADD_BTN_IDENTIFIER
        doneBtn.accessibilityIdentifier = Constants.NEW_MOVIE_DONE_BTN_IDENTIFIER
        resetBtn.accessibilityIdentifier = Constants.NEW_MOVIE_RESET_BTN_IDENTIFIER
        
    }
}

// MARK: image picker delegate
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

extension NewMovieViewController:NewMovieViewControllerDelegate
{
    func showAlert(alert: UIAlertController) {
        self.present(alert, animated: true, completion: nil)

    }
    
    
}

extension NewMovieViewController:UITextFieldDelegate
{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
