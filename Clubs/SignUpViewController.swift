//
//  SignUpViewController.swift
//  Clubs
//
//  Created by Héctor Rábago on 4/11/16.
//
//

import UIKit
import Parse

class SignUpViewController: UIViewController {

    @IBOutlet weak var newEmailField: UITextField!
    @IBOutlet weak var newUserField: UITextField!
    @IBOutlet weak var newPwField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSignUp(sender: AnyObject) {
        
        let newUser = PFUser()
        
        newUser.username = newUserField.text
        
        newUser.password = newPwField.text
        
        newUser.email = newEmailField.text
        
        newUser.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if success {
                
                print("Created New User")
                
                PFUser.logInWithUsernameInBackground(self.newUserField.text!, password: self.newPwField.text!) { (user: PFUser?, error: NSError?) -> Void in
                    
                    if user != nil{
                        
                        print("Login Worked!")
                        
                        self.performSegueWithIdentifier("signUpSuccessful", sender: nil)
                    }
                    else{
                        print("Login Failed")
                        
                    }
                }
                
                
            }else{
                
                print(error?.localizedDescription)
                
                if error?.code == 202{
                    
                    print("Username Takem!")
                }
                
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
