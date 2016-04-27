//
//  User.swift
//  Clubs
//
//  Created by Héctor Rábago on 4/15/16.
//
//

import UIKit
import Parse
import ParseUI

class User: NSObject {
    
    
    
    class func postUserImage(image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
        
        
        // Create Parse object PFObject
        let user = PFObject(className: "User")
        
        print("Saving user image")
        
        // Add relevant fields to the object
        user["name"] = PFUser.currentUser() // Pointer column type that points to PFUser
        user["profileImage"] = getPFFileFromImage(image)
        user["events"] = 0
        user["subscriptions"] = 0
        
        
        
        // Save object (following function will save the object in Parse asynchronously)
        user.saveInBackgroundWithBlock(completion)
        print("user image save complete")
    }
    
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        
        // check if image is not nil
        if let image = image {
            
            // get image data and check if that is not nil
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }
    
    
    
    
}