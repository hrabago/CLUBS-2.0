import UIKit
import Parse
import ParseUI

class MyClubsViewController: UIViewController, UIGestureRecognizerDelegate, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
  
    
    var clubEventPosts: [PFObject]!
    
    var clubNameArray: [String]!
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.reloadData()
        
        clubNameArray = ["CSS","Codepath", "Cryptocurrency"]
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        
        if let row = tableView.indexPathForSelectedRow {
            self.tableView.deselectRowAtIndexPath(row, animated: false)
        }
        
        
        PFUser.currentUser()!.fetchInBackgroundWithBlock({ (currentUser: PFObject?, error: NSError?) -> Void in
            
            // Update your data
            
            if let user = currentUser as? PFUser {
                
                if user.authenticated{
                    
                }
                
            }
        })

        
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        //return self.clubEventPosts == nil ? 0 : self.clubEventPosts.count
        return 20
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ClubTableViewCell") as! ClubTableViewCell
        //cell.clubEventPost = clubEventPosts[indexPath.row]
        
        
        switch(indexPath.row){
            
        case 0:
            
            cell.clubNameLabel.text = clubNameArray[indexPath.row]
            
        case 1:
            
            cell.clubNameLabel.text = clubNameArray[indexPath.row]
            
        default:
            
            cell.clubNameLabel.text = "Other Club"
            
        }
        
        
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
