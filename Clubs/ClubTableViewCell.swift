//
//  ClubTableViewCell.swift
//  Clubs
//
//  Created by Héctor Rábago on 4/21/16.
//
//

import UIKit
import Parse


class ClubTableViewCell: UITableViewCell {
    
    @IBOutlet weak var clubNameLabel: UILabel!
    @IBOutlet weak var clubImageView: UIImageView!
    @IBOutlet weak var clubDescriptionLabel: UILabel!
    @IBOutlet weak var clubLocationLabel: UILabel!
    
    
    var clubEventPost: PFObject!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
