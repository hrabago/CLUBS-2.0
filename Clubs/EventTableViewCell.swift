//
//  EventTableViewCell.swift
//  Clubs
//
//  Created by Héctor Rábago on 3/19/16.
//
//

import UIKit
import Parse
import ParseUI


class EventTableViewCell: UITableViewCell {
    
    @IBOutlet weak var eventHostClub: UILabel!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    @IBOutlet weak var eventImage: UIImageView!

    @IBOutlet weak var eventCover: PFImageView!
    @IBOutlet weak var eventDayLabel: UILabel!
    @IBOutlet weak var eventMonthLabel: UILabel!
    
    var months = ["JANUARY","FEBRUARY", "MARCH","APRIL",
                  "MAY","JUNE","JULY", "AUGUST",
                  "SEPTEMBER","OCTOBER","NOVEMBER","DECEMBER"]
    
    
    var clubEventPost: PFObject! {
        
        
        didSet {
            
            self.eventTitle.text = clubEventPost["eventTitle"] as? String
            
            let photo = clubEventPost["event"] as! PFObject
            
            print(clubEventPost["author"] as? String)

            self.eventHostClub.text = clubEventPost["author"] as? String
            
            
            self.eventDate.text = clubEventPost["date"] as? String
            
            let str = clubEventPost["date"] as? String
            
            
            self.eventDayLabel.text = "\(dayNumFromDateStr(str!))"
            
            self.eventMonthLabel.text = monthNamefromDateStr(str!)
            
            self.eventCover.file = photo["image"] as? PFFile
            
            self.eventCover.loadInBackground()
            
            
        }
    }
    
    func monthNamefromDateStr(str: String) -> String{
        
        let month = str.substringToIndex( str.rangeOfString("/", options: .LiteralSearch, range: nil, locale: nil)?.startIndex ?? str.startIndex )
        
        let monthNum = Int(month)!

        
        return months[monthNum-1]
        
        
    }
    
    func dayNumFromDateStr(str: String) -> Int{
        
        let month = str.substringToIndex( str.rangeOfString("/", options: .LiteralSearch, range: nil, locale: nil)?.startIndex ?? str.startIndex )
        
        let day = str.substringWithRange(Range<String.Index>(start: str.startIndex.advancedBy(month.characters.count + 1), end: str.startIndex.advancedBy(month.characters.count + 3)))
        
        let dayNum = Int(day)!
        
        return dayNum
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
