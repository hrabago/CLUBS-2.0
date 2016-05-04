//
//  UniversitiesViewController.swift
//  Clubs
//
//  Created by Héctor Rábago on 4/29/16.
//
//

import UIKit

class UniversitiesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    @IBOutlet weak var tableView: UITableView!
    
    var universityNames = ["Albright College", "Auburn University", "American University", "Arizona State University", "Boston University", "Brandeis University", "Brown University", "Boston College", "Bucknell University", "Case Western", "Reserve University" ,"Colgate University", "Columbia University", "Cornell University", "Dartmouth College", "Duke University", "Drexel University", "Emory University", "Florida State University", "Fordham University", "Georgia Institute of Technology", "George Washington University", "Georgetown University", "Harvard University", "Indiana University", "University of Illinois - Urbana Champagne", "Lehigh University", "Massachusetts Institute of Technology", "Michigan State University"]
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    

        // Do any additional setup after loading the view.
        
        tableView.reloadData()
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return universityNames.count
    }
  
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UniversityCell") as! UniversityNameTableViewCell
        
        cell.uNameLabel.text = universityNames[indexPath.row]
        
        
        return cell
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
