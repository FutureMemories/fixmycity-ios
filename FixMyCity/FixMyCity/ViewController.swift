import UIKit
import MapKit
import SwiftyJSON
import PromiseKit

class ViewController: UIViewController, MKMapViewDelegate {
    let transfer = Transfer()
    
    @IBOutlet weak var mapView: MKMapView!
    var annotations = [MKPointAnnotation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        fetchIssues()
//        transfer.postJson("", parameters: [:]) { (responseString) in
//            
//        }
//        setupPins()
        
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
    
    func fetchIssues() {
        let promise = transfer.getJsonPromise("issues", parameters: [:])
        
        promise.then { json -> Void in
//            print(json)
            let issues = self.parseIssues(json)
            self.setupPins(issues)
            self.centerMapOnLocation(self.annotations[0], regionRadius: 1000.0)
        }
        
//        return promise.then { json -> [Issue] in
//            return parseIssues(json)
//        }
    }
    
    func parseIssues(json : JSON) -> [Issue] {
        var allIssues = [Issue]()
        let issuesData: Array = json.array!
        
        for issueData in issuesData {
            let issueType = issueData["type"].stringValue
            let issueComment = issueData["comment"].stringValue
            let issueCategory = issueData["category"].stringValue
            let issuePosition = issueData["position"].dictionaryObject
            
            print(issuePosition!["long"])
            let long = issuePosition!["long"] as! Double
            let lat = issuePosition!["lat"] as! Double
            
            let issue = Issue(type: issueType, category: issueComment, comment: issueCategory, position: issuePosition!, longitude: long, latitude: lat)
            
            allIssues.append(issue)
        }
        
        return allIssues
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if (annotation is MKUserLocation) { return nil }
        
        let reuseID = "pin"
        var v = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseID)
        
        if v != nil {
            v!.annotation = annotation
        } else {
            v = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseID)
            v!.canShowCallout = true
//            v!.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
            
            if annotation.title! == "Förslag" {
                v!.image = UIImage(named:"pin_forslag")
            } else if annotation.title! == "Fråga" {
                v!.image = UIImage(named:"pin_fraga")
            } else if annotation.title! == "Beröm" {
                v!.image = UIImage(named:"pin_berom")
            } else if annotation.title! == "Problem" {
                v!.image = UIImage(named:"pin_problem")
            } else if annotation.title! == "Skadat & trasigt" {
                v!.image = UIImage(named:"pin_skada")
            } else if annotation.title! == "Renhållning" {
                v!.image = UIImage(named:"pin_renhallning")
            }
        }
        
        return v
    }
    
    func setupPins(issues: [Issue]) {
        
        for issue in issues {
            let latitude = CLLocationDegrees(issue.latitude)
            let longitude = CLLocationDegrees(issue.longitude)
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)

            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = issue.type
            annotation.subtitle = issue.comment
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

