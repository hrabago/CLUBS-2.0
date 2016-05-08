//
//  ProfileViewController.swift
//  Clubs
//
//  Created by Héctor Rábago on 4/12/16.
//
//

import UIKit
import Parse
import ParseUI
import NVActivityIndicatorView

class ProfileViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    
    var loadingView: NVActivityIndicatorView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        self.startLoading()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
        
        
        //tableView.sectionFooterHeight = 0.0
        // Do any additional setup after loading the view.
        
        //tableView.rowHeight = UITableViewAutomaticDimension
        //tableView.estimatedRowHeight = 120
        
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        
        
        
        if let row = tableView.indexPathForSelectedRow {
            self.tableView.deselectRowAtIndexPath(row, animated: false)
        }
        
        
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return 10
        
        
    }
    
    
    //HEADER
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        
        let header = tableView.dequeueReusableCellWithIdentifier("HeaderCell") as! ProfileHeaderCell
        
        PFUser.currentUser()!.fetchInBackgroundWithBlock({ (currentUser: PFObject?, error: NSError?) -> Void in
            
            // Update your data
            
            if let user = currentUser as? PFUser {
                
                let email = user.email
                let name = user.username
                let password = user.password
                
                let fullName = "\(user["FirstName"]) \(user["LastName"])"
                
                
                header.nameLabel.text = fullName
                
                print("header label \(fullName)")
                
                self.stopLoading()
                
            }
        })
        



        
        return header.contentView
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        
        return 200.0
    }
    //FOOTER
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
        
        return CGFloat.min

    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
     
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ProfileCell", forIndexPath: indexPath) as!
        ProfileCell
        
        
        return cell
    }
    
    @IBAction func onLogOut(sender: AnyObject) {
        
        self.startLoading()
        
        PFUser.logOutInBackgroundWithBlock { (error: NSError?) -> Void in
            if let error = error {
                print("Error while trying to logout: \(error)")
            } else {
                
                print("Log out Worked")
                NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil)
                //self.performSegueWithIdentifier("onLogoutSegue", sender: nil)
                self.stopLoading()
                
            }
        }
    }
    
    func startLoading(){
        
        self.tableView.alpha = 0.0
        print("Viewdidload")
        let viewW = self.view.frame.width/4
        let viewH = self.view.frame.height/4
        let xV = self.view.frame.width/2 - viewW/2
        let yV = viewH/2
        
        let frame = CGRect(x: xV, y: yV, width: viewW, height: viewH)
        
        loadingView = NVActivityIndicatorView(frame: frame)
        
        
        loadingView.type = .BallClipRotate //.BallScaleRippleMultiple
        
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
                    self.tableView.alpha = 1.0
                    }, completion: nil)
        })
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


