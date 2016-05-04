//
//  ClubHeaderCell.swift
//  Clubs
//
//  Created by Héctor Rábago on 4/21/16.
//
//

import UIKit

class ClubHeaderCell: UITableViewCell {
    
    @IBOutlet weak var clubNameLabel: UILabel!
    @IBOutlet weak var clubLocationLabel: UILabel!
    @IBOutlet weak var clubDescriptionLabel: UILabel!
    
    @IBOutlet weak var detailClubImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
