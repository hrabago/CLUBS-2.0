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
import ParseUI
import NVActivityIndicatorView


class EventsViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UIGestureRecognizerDelegate, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var locationView: UIView!
    @IBOutlet weak var feedView: UIView!

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    
    
    var clubEventPosts: [PFObject]!
    var location: NSDictionary!

    var locationManager: CLLocationManager!
    
    var loadingView: NVActivityIndicatorView!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.alpha = 0.0
        print("Viewdidload")
        let viewW = self.view.frame.width/4
        let viewH = self.view.frame.height/4
        let xV = self.view.frame.width/2 - viewW/2
        let yV = viewH/2
        
        let frame = CGRect(x: xV, y: yV, width: viewW, height: viewH)
        
        loadingView = NVActivityIndicatorView(frame: frame)

        
        loadingView.type = .BallPulseSync //.BallScaleRippleMultiple
        
        loadingView.color = UIColor(red:92/255, green: 55/255, blue: 153/255, alpha: 1.0)
        
        loadingView.padding = 20
        
        loadingView.startAnimation()
        self.view.addSubview(loadingView)
        
        //let centerLocation = CLLocation(latitude: 37.7833, longitude: -122.4167)
        //goToLocation(centerLocation)
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        
        
        if CLLocationManager.locationServicesEnabled() {
            //locationManager.startUpdatingLocation()
        }
        
        mapView.delegate = self
        mapView.showsUserLocation = true
        
        self.addAnnotationAtCoordinate(CLLocationCoordinate2D(latitude: 40.86144831,longitude: -73.8861157))
        
        let request = MKDirectionsRequest()
        request.source = MKMapItem.mapItemForCurrentLocation()
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 40.86144831, longitude: -73.8861157), addressDictionary: nil))
        request.requestsAlternateRoutes = true
        request.transportType = .Walking
        
        let directions = MKDirections(request: request)
        
        directions.calculateDirectionsWithCompletionHandler { [unowned self] response, error in
            guard let unwrappedResponse = response else { return }
            
            for route in unwrappedResponse.routes {
                self.mapView.addOverlay(route.polyline)
                self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            }
        }
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.reloadData()
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        if let row = tableView.indexPathForSelectedRow {
            self.tableView.deselectRowAtIndexPath(row, animated: false)
        }
        
        
        self.getClubEventsFromParse()

    }
    func getClubEventsFromParse() {
        
        print("Retrieving Instagram Posts from Parse...")
        
        let query = PFQuery(className: "Event")
        query.orderByDescending("createdAt")
        query.includeKey("event")
        query.findObjectsInBackgroundWithBlock { (results: [PFObject]?, error: NSError?) -> Void in
            if let error = error {
                print("Error: \(error)")
            } else {
                if let results = results {
                    print("Successfully retrieved \(results.count) posts")
                    
                    self.clubEventPosts = results
                    self.tableView.reloadData()
                    self.stopLoading()

                } else {
                    print("No results returned")
                }
            }
        }
    }
    /*
    func goToLocation(location: CLLocation) {
        let span = MKCoordinateSpanMake(0.1, 0.1)
        let region = MKCoordinateRegionMake(location.coordinate, span)
        mapView.setRegion(region, animated: false)
    }*/
    
    func goToLocation(location: CLLocation) {
        
        let latDelta = CLLocationDegrees(1.1)
        let lonDelta = CLLocationDegrees(1.1)
        let span = MKCoordinateSpanMake(latDelta, lonDelta)
        let region = MKCoordinateRegionMake(location.coordinate, span)
        mapView.setRegion(region, animated: true)
        
        // Need to set a delay before the next function plays
    }
    
    func zoomOnLocation(location: CLLocation) {
        let latDelta = CLLocationDegrees(0.01)
        let lonDelta = CLLocationDegrees(0.01)
        let span = MKCoordinateSpanMake(latDelta, lonDelta)
        let region = MKCoordinateRegionMake(location.coordinate, span)
        mapView.setRegion(region, animated: true)
    }
    
    func addAnnotationAtCoordinate(coordinate: CLLocationCoordinate2D) {
        //let view = location["location"] as! [String: AnyObject]
        //let locName = view["name"] as! String
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "Dealy Hall"
        mapView.addAnnotation(annotation)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return self.clubEventPosts == nil ? 0 : self.clubEventPosts.count
        //return 20
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
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        

        if status == CLAuthorizationStatus.AuthorizedWhenInUse || status == .AuthorizedAlways {
            locationManager.startUpdatingLocation()
        }
    }
    
    /*func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        
        if let location = locations.first {
            let span = MKCoordinateSpanMake(0.01, 0.01)
            let region = MKCoordinateRegionMake(location.coordinate, span)
            mapView.setRegion(region, animated: false)
        }
    }*/

    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
        renderer.strokeColor = UIColor.purpleColor()
        renderer.lineWidth = 1.0
        return renderer
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
