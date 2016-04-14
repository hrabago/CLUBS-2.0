//
//  ProfileViewController.swift
//  Clubs
//
//  Created by Héctor Rábago on 4/12/16.
//
//

import UIKit

class ProfileViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return 5
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
     
        let cell = tableView.dequeueReusableCellWithIdentifier("ProfileTableViewCell", forIndexPath: indexPath) as! ProfileTableViewCell
        
        return cell
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


