//
//  LogInViewController.swift
//  Clubs
//
//  Created by Héctor Rábago on 3/17/16.
//
//

import UIKit
import JavaScriptCore
import Parse
import NVActivityIndicatorView


class LogInViewController: UIViewController {
    
    @IBOutlet weak var userField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var pwField: UITextField!
    @IBOutlet weak var buttonBottomConstraint: NSLayoutConstraint!
    
    var loadingView: NVActivityIndicatorView!


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        buttonBottomConstraint.constant = 0.0
        
        self.hideKeyboardWhenTappedAround()

    
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
    
        startLoading()
        
        PFUser.logInWithUsernameInBackground(userField.text!, password: pwField.text!) { (user: PFUser?, error: NSError?) -> Void in
            
            if user != nil{
                
                print("Login Worked!")
                self.stopLoading()
                
                self.performSegueWithIdentifier("loginSuccessful", sender: nil)
            }
            else{
                print("Login Failed")
                
            }
        }
        
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
    func startLoading(){
        
        print("Viewdidload")
        let viewW = self.view.frame.width/4
        let viewH = self.view.frame.height/4
        let xV = self.view.frame.width/2 - viewW/2
        let yV = viewH/2
        
        let frame = CGRect(x: xV, y: yV, width: viewW, height: viewH)
        
        loadingView = NVActivityIndicatorView(frame: frame)
        
        
        loadingView.type = .BallScaleRippleMultiple //.BallScaleRippleMultiple
        
        loadingView.color = UIColor(red:92/255, green: 55/255, blue: 153/255, alpha: 1.0)
        
        loadingView.padding = 20
        
        loadingView.startAnimation()
        self.view.addSubview(loadingView)
    }
    
    func stopLoading(){
        UIView.animateWithDuration(0.5, delay: 0.0, options:
            
            UIViewAnimationOptions.CurveEaseOut, animations: {
                self.loadingView.alpha = 0.0
            }, completion: {
                (finished: Bool) -> Void in
                
                UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                    
                    }, completion: nil)
        })
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
