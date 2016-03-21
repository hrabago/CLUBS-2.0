//
//  ViewController.swift
//  Clubs
//
//  Created by Héctor Rábago on 3/4/16.
//
//

import UIKit



class ViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
    }
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLogin(sender: AnyObject) {
    

        UIView.animateWithDuration(0.5
            , animations: { () -> Void in
                
                self.loginButton.center.y = self.view.frame.height - self.loginButton.frame.height/2
                //self.loginButton.alpha = 0.2
                
                
        }) { (Bool) -> Void in
         self.performSegueWithIdentifier("loginStorySegue", sender: nil)
        }
    
    
    }

}

