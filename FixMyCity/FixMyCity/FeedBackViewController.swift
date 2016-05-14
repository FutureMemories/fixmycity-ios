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
