//
//  SignUpViewController.swift
//  Clubs
//
//  Created by Héctor Rábago on 4/11/16.
//
//

import UIKit
import Parse
import NVActivityIndicatorView

class SignUpViewController: UIViewController {

    @IBOutlet weak var newEmailField: UITextField!
    @IBOutlet weak var newUserField: UITextField!
    @IBOutlet weak var newPwField: UITextField!
    @IBOutlet weak var userFirstNameField: UITextField!
    @IBOutlet weak var userLastNameField: UITextField!
    
    
    var loadingView: NVActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSignUp(sender: AnyObject) {
        
        self.startLoading()
        
        let newUser = PFUser()
        
        newUser.username = newUserField.text
        
        newUser.password = newPwField.text
        
        newUser.email = newEmailField.text
        
        newUser["FirstName"] = userFirstNameField.text
        
        newUser["LastName"] = userLastNameField.text
        
        
        
        
        newUser.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if success {
                
                print("Created New User")
                
                PFUser.logInWithUsernameInBackground(self.newUserField.text!, password: self.newPwField.text!) { (user: PFUser?, error: NSError?) -> Void in
                    
                    if user != nil{
                        
                        print("Login Worked!")
                        self.stopLoading()
                        
                        self.performSegueWithIdentifier("signUpSuccessful", sender: nil)
                    }
                    else{
                        self.stopLoading()
                        print("Login Failed")
                        
                    }
                }
                
                
            }else{
                
                print(error?.localizedDescription)
                
                if error?.code == 202{
                    
                    print("Username Taken!")
                    
                    self.stopLoading()
                }
                
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
