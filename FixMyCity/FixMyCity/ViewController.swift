import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var annotations = [MKPointAnnotation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        setupPins()
        centerMapOnLocation(annotations[0], regionRadius: 1000.0)
    }

    override func viewDidAppear(animated: Bool) {
        let titleColor = UIColor(red: 33/255, green: 150/255, blue: 243/255, alpha: 1)
        self.navigationController?.navigationBar.topItem?.title = "FixMyCity"
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "CircularStd-Bold", size: 24)!,  NSForegroundColorAttributeName: titleColor]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func addFeedback(sender: AnyObject) {
        performSegueWithIdentifier("feedbackSegue", sender: self)
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if (annotation is MKUserLocation) { return nil }
        
        let reuseID = "pin"
        var v = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseID)
        
        if v != nil {
            v!.annotation = annotation
        } else {
            v = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseID)
            
            v!.image = UIImage(named:"pin_fraga")
        }
        
        return v
    }
    
    func setupPins() {
        let locations = [
            ["name" : "Sunkstan",
                "latitude" : 57.70833,
                "longitude" : 11.96913,
                "mediaURL" : "http://www.apple.com"],
            ["name" : "raj raj",
                "latitude" : 57.71333,
                "longitude" : 11.96778,
                "mediaURL" : "http://www.bjsrestaurants.com"]
        ]
        
        
        
        for dictionary in locations {
            let latitude = CLLocationDegrees(dictionary["latitude"] as! Double)
            let longitude = CLLocationDegrees(dictionary["longitude"] as! Double)
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let name = dictionary["name"] as! String
            let mediaURL = dictionary["mediaURL"] as! String
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "\(name)"
            annotation.subtitle = mediaURL
            annotations.append(annotation)
        }
        mapView.addAnnotations(annotations)
    }
    
    func centerMapOnLocation(location: MKPointAnnotation, regionRadius: Double) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}

