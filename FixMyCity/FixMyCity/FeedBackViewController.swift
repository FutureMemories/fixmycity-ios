import UIKit

class FeedBackViewController: UIViewController, FeedbackMenuDelegate, ReportViewDelegate {
    var selectedMenuItem : MenuItem!
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let attributedTitle = NSAttributedString(string: "STÄNG",
                                                           attributes: [NSForegroundColorAttributeName : UIColor.whiteColor(), NSFontAttributeName: UIFont(name: "CircularStd-Book", size: 24)!])
        closeButton.setAttributedTitle(attributedTitle, forState: .Selected)
        closeButton.setAttributedTitle(attributedTitle, forState: .Normal)
        
        headerLabel.font = UIFont(name: "CircularStd-Book", size: 24)
        
        let datasource = collectionView.dataSource as! CollectionViewDataSource
        datasource.delegate = self
        
        let menuItem1 = MenuItem(header: "Förslag", imageName: "Forslag")
        let menuItem2 = MenuItem(header: "Fråga", imageName: "Fraga")
        let menuItem3 = MenuItem(header: "Beröm", imageName: "Berom")
        let menuItem4 = MenuItem(header: "Problem", imageName: "Problem")
        let menuItem5 = MenuItem(header: "Skada", imageName: "Trasigt")
        let menuItem6 = MenuItem(header: "Renhållning", imageName: "Renhallning")
        
        datasource.menuItems = [menuItem1,menuItem2,menuItem3,menuItem4,menuItem5,menuItem6]
//        collectionView.reloadData()
    }
    
    func addItemsToMenu() {
        
    }
    override func viewDidAppear(animated: Bool) {
        showUI()
    }
    
    func showUI() {
        self.collectionView.alpha = 1
        
        headerLabel.alpha = 0
        headerLabel.layer.transform = CATransform3DMakeScale(0.5, 0.5, 0.5)
        closeButton.alpha = 0
        closeButton.layer.transform = CATransform3DMakeScale(0.5, 0.5, 0.5)

        UIView.animateWithDuration(0.2, animations: {
            self.headerLabel.alpha = 1
            self.headerLabel.layer.transform = CATransform3DScale(CATransform3DIdentity, 1, 1, 1)
            
        }) { (true) in
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                self.closeButton.alpha = 1
                self.closeButton.layer.transform = CATransform3DScale(CATransform3DIdentity, 1, 1, 1)
            })
        }
    }
    
    func hideUI() {
        UIView.animateWithDuration(0.2, animations: {
            self.headerLabel.alpha = 0
            self.headerLabel.layer.transform = CATransform3DScale(CATransform3DIdentity, 0, 0, 0)
            self.collectionView.alpha = 0
            
            self.closeButton.alpha = 0
            self.closeButton.layer.transform = CATransform3DScale(CATransform3DIdentity, 0, 0, 0)
            
        }) { (true) in
//            UIView.animateWithDuration(0.1, animations: { () -> Void in
//                self.closeButton.alpha = 0
//                self.closeButton.layer.transform = CATransform3DScale(CATransform3DIdentity, 0, 0, 0)
//            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    @IBAction func closeMe(sender: AnyObject) {
        dismissViewControllerAnimated(false, completion: nil)
    }
    
    // MARK: Delegates
    func menuItemTapped(menuItem: MenuItem) {
        selectedMenuItem = menuItem
        hideUI()
        performSegueWithIdentifier("ReportSegue", sender: self)
    }
    
    func closeReport() {
        showUI()
        collectionView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ReportSegue" {
            let dest = segue.destinationViewController as! ReportViewController
            dest.menuItem = selectedMenuItem
            dest.delegate = self
        }
    }
}
