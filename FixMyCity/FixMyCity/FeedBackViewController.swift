import UIKit

class FeedBackViewController: UIViewController, FeedbackMenuDelegate {

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
        
        
        
    }
    override func viewDidAppear(animated: Bool) {
        showUI()
    }
    
    func showUI() {
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    @IBAction func closeMe(sender: AnyObject) {
        dismissViewControllerAnimated(false, completion: nil)
    }
    
    func menuItemTapped(num: Int) {
        print(num)
    }
}
