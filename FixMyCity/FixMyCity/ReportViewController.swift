import UIKit

protocol ReportViewDelegate {
    func closeReport()
}

class ReportViewController: UIViewController,CategoriesDelegate {
    var menuItem : MenuItem!
    var delegate : ReportViewDelegate!
    
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var catLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        header.font = UIFont(name: "CircularStd-Book", size: 24)
        
        icon.image = UIImage(named: menuItem.imageName)
        header.text = menuItem.header
        
    }

    override func viewDidAppear(animated: Bool) {
        showUI()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showUI() {
        
        
        header.alpha = 0
        header.layer.transform = CATransform3DMakeScale(0.5, 0.5, 0.5)
        icon.alpha = 0
        icon.layer.transform = CATransform3DMakeScale(0.5, 0.5, 0.5)
        
        UIView.animateWithDuration(0.2, animations: {
            self.header.alpha = 1
            self.header.layer.transform = CATransform3DScale(CATransform3DIdentity, 1, 1, 1)
            self.icon.alpha = 1
            self.icon.layer.transform = CATransform3DScale(CATransform3DIdentity, 1, 1, 1)
            
            
        }) { (true) in
//            UIView.animateWithDuration(0.2, animations: { () -> Void in
//                self.closeButton.alpha = 1
//                self.closeButton.layer.transform = CATransform3DScale(CATransform3DIdentity, 1, 1, 1)
//            })
        }
    }

    @IBAction func showCategories(sender: AnyObject) {
                self.view.hidden = true
        performSegueWithIdentifier("showCatagoriesSegue", sender: self)
    }
    
    @IBAction func closeMe(sender: AnyObject) {
        delegate.closeReport()

        dismissViewControllerAnimated(false, completion: nil)
    }
    
    func categorySelected(cat : String) {
        catLabel.text = cat
        self.view.hidden = false
        showUI()
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showCatagoriesSegue" {
            let dest = segue.destinationViewController as! CategoriesTableViewController
            dest.delegate = self
        }
    }
}
