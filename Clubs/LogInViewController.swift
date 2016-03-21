//
//  LogInViewController.swift
//  Clubs
//
//  Created by Héctor Rábago on 3/17/16.
//
//

import UIKit
import JavaScriptCore


class LogInViewController: UIViewController {
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var pwField: UITextField!
    @IBOutlet weak var buttonBottomConstraint: NSLayoutConstraint!
    


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        buttonBottomConstraint.constant = 0.0
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    @IBAction func didBegin(sender: AnyObject) {
        self.signInButton.hidden = false

        
        UIView.animateWithDuration(0.5
            , animations: { () -> Void in
                
                //self.signInButton.center.x += self.view.bounds.width
                self.signInButton.alpha = 1
                
                
            }) { (Bool) -> Void in
                
                print("Completed 1")
        }
        
    }

    @IBAction func didEnd(sender: AnyObject) {

        if pwField.text == ""
        {
            self.signInButton.hidden = true
        }
            
        UIView.animateWithDuration(0.5) { () -> Void in

            
            
            print("didEnd")

        }
    }
    
    
    @IBAction func pressedLogIn(sender: AnyObject) {
    
        self.performSegueWithIdentifier("loginSuccessful", sender: nil)
        
    }
    
    func keyboardWillShow(sender: NSNotification) {
        if let userInfo = sender.userInfo {
            if let keyboardHeight = userInfo[UIKeyboardFrameEndUserInfoKey]?.CGRectValue.size.height {
                buttonBottomConstraint.constant = keyboardHeight
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
