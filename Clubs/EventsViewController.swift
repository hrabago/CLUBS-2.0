//
//  EventsViewController.swift
//  Clubs
//
//  Created by Héctor Rábago on 3/19/16.
//
//

import UIKit
import MapKit
import CoreLocation
import Parse

class EventsViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UIGestureRecognizerDelegate, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var locationView: UIView!
    @IBOutlet weak var feedView: UIView!

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    
    var clubEventPosts: [PFObject]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let centerLocation = CLLocation(latitude: 37.7833, longitude: -122.4167)
        goToLocation(centerLocation)
    }
    
    func goToLocation(location: CLLocation) {
        let span = MKCoordinateSpanMake(0.1, 0.1)
        let region = MKCoordinateRegionMake(location.coordinate, span)
        mapView.setRegion(region, animated: false)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return self.clubEventPosts == nil ? 0 : self.clubEventPosts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCellWithIdentifier("EventCell") as! EventTableViewCell
        cell.clubEventPost = clubEventPosts[indexPath.row]
        return cell

    }

    
    @IBAction func indexChanged(sender: AnyObject) {
        
        switch sender.selectedSegmentIndex {
            
        case 0:
            mapView.hidden = true
            feedView.hidden = false
            
        case 1:
            mapView.hidden = false
            feedView.hidden = true
        default:
            break;
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
