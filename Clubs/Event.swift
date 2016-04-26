//
//  Event.swift
//  Clubs
//
//  Created by Héctor Rábago on 4/15/16.
//
//

import UIKit
import Parse

class Event: NSObject {
    
    
    var eventTitle: NSString?
    var eventDescription: NSString?
    var eventDate:NSString?
    var eventHost: NSString?
    var eventLocationName: NSString?
    
    
    var eventLocation: CLLocationCoordinate2D?
    var eventLongitude: Double?
    var eventLatitude: Double?
    var eventImage: UIImage?
    
    
    var dictionary: NSDictionary?
    var userClubs:[NSString]?
    

    
    init(object : PFObject) {
        
        super.init()
        
        // Create Parse object PFObject
        let newObject = object
        
        // Add relevant fields to the object
        //  author = newObject["author"] as! String
        eventTitle = newObject["eventTitle"] as! String
        eventDescription = newObject["eventDescription"] as! String
        eventDate = newObject["commentsCount"] as! String
        eventHost = newObject["eventHost"] as! String
        
        eventLocationName = newObject["eventLocationName"] as! String
        
        eventLatitude = newObject["eventLatitude"] as? Double
        eventLongitude = newObject["eventLongitude"] as? Double

        
        eventLocation = CLLocationCoordinate2D(latitude: eventLatitude!, longitude: eventLongitude!)
        

        
        
        if let newImage = object.valueForKey("media")! as? PFFile {
            
            newImage.getDataInBackgroundWithBlock({ (imageData: NSData?, error: NSError?) -> Void in
                if (error == nil) {
                    let image = UIImage(data: imageData!)
                    self.eventImage = image!
                    
                } else {
                    print("ERROR: could not get image \(error?.localizedDescription)")
                }
                }, progressBlock: { (int: Int32) -> Void in
            })
        }
    }
}
