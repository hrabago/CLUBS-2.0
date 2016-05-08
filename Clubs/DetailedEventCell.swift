//
//  DetailedEventCell.swift
//  Clubs
//
//  Created by Héctor Rábago on 5/8/16.
//
//

import UIKit

class DetailedEventCell: UITableViewCell {
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userCommentLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        userImage.layer.borderWidth = 1
        userImage.layer.masksToBounds = false
        userImage.layer.cornerRadius = userImage.frame.height/2
        
        
        userImage.clipsToBounds = true
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
