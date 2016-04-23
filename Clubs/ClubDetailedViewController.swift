//
//  ClubDetailedViewController.swift
//  Clubs
//
//  Created by Héctor Rábago on 4/21/16.
//
//



import UIKit
import Parse
import ParseUI

class ClubDetailedViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        let header = tableView.dequeueReusableCellWithIdentifier("ClubHeaderCell") as! ClubHeaderCell
        
        header.clubNameLabel.text = "Computer Science Society (CSS)"
        
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
        
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ClubEventsCell", forIndexPath: indexPath) as! ClubEventsCell
        
        
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


