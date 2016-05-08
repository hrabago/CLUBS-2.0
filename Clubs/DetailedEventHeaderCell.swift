//
//  DetailedEventHeaderCell.swift
//  Clubs
//
//  Created by Héctor Rábago on 5/8/16.
//
//

import UIKit

class DetailedEventHeaderCell: UITableViewCell {
    @IBOutlet weak var clubImageView: UIImageView!
    @IBOutlet weak var clubNameLabel: UILabel!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventDescriptionLabel: UILabel!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var maybeButton: UIButton!
    @IBOutlet weak var noButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
