//
//  DetailedEventViewController.swift
//  Clubs
//
//  Created by Héctor Rábago on 4/15/16.
//
//

import UIKit
import Parse
import MapKit
import CoreLocation



class DetailedEventViewController: UIViewController, UITextViewDelegate, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate, MKMapViewDelegate{


    @IBOutlet weak var postCommentButton: UIButton!

    @IBOutlet weak var commentTextView: UITextView!
    
    @IBOutlet weak var commentViewBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var eventView: UIView!
    @IBOutlet weak var mapKitView: MKMapView!
    
    var location: NSDictionary!
    
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        
        self.hideKeyboardWhenTappedAround()

        commentTextView.delegate = self
        commentTextView.textColor = UIColor.blackColor()
        commentTextView.text = "Write a comment..."
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        
        //commentFBottomConstraint.constant = 0.0
        //postButtonBottomConstraint.constant = 0.0
        
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        
        
        if CLLocationManager.locationServicesEnabled() {
            //locationManager.startUpdatingLocation()
        }
        
        mapKitView.delegate = self
        mapKitView.showsUserLocation = true
        
        self.addAnnotationAtCoordinate(CLLocationCoordinate2D(latitude: 40.86144831,longitude: -73.8861157))
        
        let request = MKDirectionsRequest()
        
        request.source = MKMapItem.mapItemForCurrentLocation()
        
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 40.86144831, longitude: -73.8861157), addressDictionary: nil))
        
        //request.requestsAlternateRoutes = true
        request.transportType = .Walking
        
        let directions = MKDirections(request: request)
        
        directions.calculateDirectionsWithCompletionHandler {
            
            [unowned self] response, error in
            guard let unwrappedResponse = response else { return }
            
            for route in unwrappedResponse.routes {
                self.mapKitView.addOverlay(route.polyline)
                self.mapKitView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            }
        
        }
        
    }
        

    func textViewDidBeginEditing(textView: UITextView) {
        
        if commentTextView.textColor == UIColor.blackColor() {
            commentTextView.text = nil
            
        }
    }

    override func viewWillAppear(animated:Bool){
            super.viewWillAppear(true)
            
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func dismissKeyboard() {
        

        commentViewBottomConstraint.constant = 0.0
        
        if commentTextView.text == ""{
            
            commentTextView.text = "Write a comment..."
        }
        
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
        view.endEditing(true)

    }
    
    func keyboardWillShow(sender: NSNotification) {
        
        if let userInfo = sender.userInfo {
            
            if let keyboardHeight = userInfo[UIKeyboardFrameEndUserInfoKey]?.CGRectValue.size.height {
                
                commentViewBottomConstraint.constant = keyboardHeight - 49.0
                
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    self.view.layoutIfNeeded()
                })
            }
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
        
        let header = tableView.dequeueReusableCellWithIdentifier("DetailedEventHeaderCell") as! DetailedEventHeaderCell
        
        PFUser.currentUser()!.fetchInBackgroundWithBlock({ (currentUser: PFObject?, error: NSError?) -> Void in
            
            // Update your data
            
            if let user = currentUser as? PFUser {
                
                let email = user.email
                let name = user.username
                let password = user.password
                
                let fullName = "\(user["FirstName"]) \(user["LastName"])"
                
                
                header.clubNameLabel.text = "Computer Science Society"
                
                print("header label \(fullName)")
                
            }
        })
        
        
        
        
        
        return header.contentView
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        
        return 300.0
    }
    //FOOTER
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
        
        return CGFloat.min
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("DetailedEventCell", forIndexPath: indexPath) as!
        DetailedEventCell
        
        
        return cell
    }

    
    @IBAction func indexChanged(sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
            
        case 0:
            mapView.hidden = true
            eventView.hidden = false
            
        case 1:
            mapView.hidden = false
            eventView.hidden = true
            
        default:
            break;
        }
    }

    
    func goToLocation(location: CLLocation) {
        
        let latDelta = CLLocationDegrees(0.001)
        let lonDelta = CLLocationDegrees(0.001)
        let span = MKCoordinateSpanMake(latDelta, lonDelta)
        
        
        let region = MKCoordinateRegionMake(location.coordinate, span)
        mapKitView.setRegion(region, animated: true)
        
        // Need to set a delay before the next function plays
    }
    
    func zoomOnLocation(location: CLLocation) {
        let latDelta = CLLocationDegrees(0.1)
        let lonDelta = CLLocationDegrees(0.1)
        let span = MKCoordinateSpanMake(latDelta, lonDelta)
        let region = MKCoordinateRegionMake(location.coordinate, span)
        mapKitView.setRegion(region, animated: true)
    }
    
    func addAnnotationAtCoordinate(coordinate: CLLocationCoordinate2D) {
        //let view = location["location"] as! [String: AnyObject]
        //let locName = view["name"] as! String
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "Dealy Hall"
        
        let latDelta = CLLocationDegrees(5.0)
        let lonDelta = CLLocationDegrees(5.0)
        let span = MKCoordinateSpanMake(latDelta, lonDelta)
        let region = MKCoordinateRegionMake(coordinate, span)
        
        mapKitView.setRegion(region, animated: true)
        
        mapKitView.addAnnotation(annotation)
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        
        if status == CLAuthorizationStatus.AuthorizedWhenInUse || status == .AuthorizedAlways {
            locationManager.startUpdatingLocation()
        }
    }
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        
        
        let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
        renderer.strokeColor = UIColor.purpleColor()
        renderer.lineWidth = 2.0
        return renderer
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
