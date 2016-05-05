//
//  NewEventViewController.swift
//  Clubs
//
//  Created by Héctor Rábago on 4/23/16.
//
//

import UIKit
import Parse
import ParseUI
import MBProgressHUD


class NewEventViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate{

   
    @IBOutlet weak var libImageView: UIImageView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var eventTitleLabel: UITextField!
    @IBOutlet weak var descriptionLabel: UITextField!
    @IBOutlet weak var eventLocation: UITextField!
    
    
    
    let imagePicker = UIImagePickerController()
    
    var draftImage: UIImage!


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imagePicker.delegate = self
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func choosePhoto(sender: AnyObject) {
        
        imagePicker.allowsEditing = true
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
        resizeImageView.contentMode = UIViewContentMode.ScaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    func imagePickerController(picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        

        
        // Update UI to reflect selected image
        
        self.draftImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        self.libImageView.image = self.draftImage
        
        self.libImageView.alpha = 1
        self.libImageView.backgroundColor = UIColor.whiteColor()
        self.dismissViewControllerAnimated(true, completion: nil)
    
        
        
    }
    
    @IBAction func onSubmitEvent(sender: AnyObject) {
        
        
        self.view.endEditing(true)
        
        // NSNotificationCenter.defaultCenter().postNotificationName("load", object: nil)
        //If statement does not prevent crash
        if libImageView.image != nil && eventTitleLabel.text != nil {
            
            submitPostToParse()
        }
            
        else {
            print("ERROR! No image and/or caption")
        }
        
    }
    
    func submitPostToParse() {
        
        // Resize and compress image
        // The image must be under 10 MB to store in Parse
        // Ideally this would be done on a background thread
        


        
        var dateFormatter = NSDateFormatter()
        
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        
        var strDate = dateFormatter.stringFromDate(datePicker.date)
        
        let scaledImage = self.resize((self.libImageView.image)!, newSize: CGSizeMake(398, 115))
        let imageData = UIImageJPEGRepresentation(scaledImage, 0)
        
        let imageFile = PFFile(name:"image.jpg", data:imageData!)
        
        let photo = PFObject(className: "Photo")
        photo["image"] = imageFile
        
    
        
        let event = PFObject(className: "Event")
        event["event"] = photo
        event["eventTitle"] = self.eventTitleLabel.text
        event["eventDescription"] = self.descriptionLabel.text
        event["date"] = strDate
        
        PFUser.currentUser()!.fetchInBackgroundWithBlock({ (currentUser: PFObject?, error: NSError?) -> Void in
            
            // Update your data
            
            if let user = currentUser as? PFUser {
                
                event["author"] = user["FirstName"]
                
            }
        })
        
        
        

    
        event.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if let error = error {
                print("Error saving post: \(error.description)")
            } else {
                print("Post saved successfully")
                
                self.initializeViews()
                self.tabBarController!.selectedIndex = 1
                
                //self.performSegueWithIdentifier("onSubmitEvent", sender: nil)
                print("Table View Top")

            }
        }
    }
    
    
    func initializeViews() {
        
        
        self.libImageView.image = nil
        self.eventTitleLabel.text = ""
        self.eventLocation.text = ""
        self.descriptionLabel.text = ""
        
        
    }

    
 
     

     
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
