//
//  RatingTableViewCell.swift
//  Rating
//

import UIKit

class RatingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ratingView: RaingView!
    
    var value: Int? {
        didSet {
            ratingView.setRating(value: value!, with: false)
        }
    }

}
