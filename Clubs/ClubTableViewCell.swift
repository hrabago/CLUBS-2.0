//
//  ClubTableViewCell.swift
//  Clubs
//
//  Created by Héctor Rábago on 4/21/16.
//
//

import UIKit
import Parse

@objc  protocol SwitchCellDelegate{
    
    optional func switchCell(switchCell: ClubTableViewCell, didChangeValue value: Bool)
    
}

class ClubTableViewCell: UITableViewCell {
    
    @IBOutlet weak var clubNameLabel: UILabel!
    @IBOutlet weak var clubImageView: UIImageView!
    @IBOutlet weak var clubDescriptionLabel: UILabel!
    @IBOutlet weak var clubLocationLabel: UILabel!
    @IBOutlet weak var followSwitch: UISwitch!
    
var clubNameArray = ["Computer Science Society", "Autism Speaks U", "Campus Activities Board", "Contemporary Sciecne Fiction", "Ampersand", "Asili", "Acedmia Hispana", "Astronomy Club", "Ballroom Dancing", "College Republicans", "Economics SOciety", "Gamers United", "Jewish Student Organization", "Korean Studenta Association", "The Ram", "Special Olympics Club at Fordham", "Robotics Club", "Psychology Club", "Model UN", "Mimers and Mummers"]
    
    var userClubSubscriptions: [String]!
    
    weak var delegate: SwitchCellDelegate?
    
    var clubEventPost: PFObject!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        clubImageView.layer.cornerRadius = 5
        clubImageView.clipsToBounds = true
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func valueDidChange(sender: UISwitch) {

        
        delegate?.switchCell?(self, didChangeValue: followSwitch.on)
    }

}
