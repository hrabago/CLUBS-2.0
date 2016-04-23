//
//  DetailedEventViewController.swift
//  Clubs
//
//  Created by Héctor Rábago on 4/15/16.
//
//

import UIKit

class DetailedEventViewController: UIViewController {


    @IBOutlet weak var postCommentButton: UIButton!
    
    @IBOutlet weak var notGoingButton: UIButton!
    
    @IBOutlet weak var yesGoingButton: UIButton!
    @IBOutlet weak var maybeGoingButton: UIButton!

    @IBOutlet weak var commentTextView: UITextView!
    
    @IBOutlet weak var commentViewBottomConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        
        self.hideKeyboardWhenTappedAround()

        
        //commentFBottomConstraint.constant = 0.0
        //postButtonBottomConstraint.constant = 0.0
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func dismissKeyboard() {
        

        commentViewBottomConstraint.constant = 0.0
        
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
        view.endEditing(true)

    }
    
    func keyboardWillShow(sender: NSNotification) {
        
        if let userInfo = sender.userInfo {
            
            if let keyboardHeight = userInfo[UIKeyboardFrameEndUserInfoKey]?.CGRectValue.size.height {
                
                commentViewBottomConstraint.constant = keyboardHeight - 49.0
                
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    self.view.layoutIfNeeded()
                })
            }
        }
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
