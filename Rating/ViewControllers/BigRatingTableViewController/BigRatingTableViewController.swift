//
//  BigRatingTableViewController.swift
//  Rating
//


import UIKit

class BigRatingTableViewController: UITableViewController {
    

    @IBOutlet weak var ratingView: RaingView!
    @IBOutlet weak var ratingTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func animateAction(_ sender: UIButton) {
        if let text = ratingTextField.text,
           let value = Int(text) {
            ratingView.setRating(value: value, with: true)
        } else {
            ratingTextField.text = ""
        }
    }
    

    
}
