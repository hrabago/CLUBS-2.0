//
//  EventTableViewCell.swift
//  Clubs
//
//  Created by Héctor Rábago on 3/19/16.
//
//

import UIKit
import Parse


class EventTableViewCell: UITableViewCell {
    
    @IBOutlet weak var eventHostClub: UILabel!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    @IBOutlet weak var eventImage: UIImageView!

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
