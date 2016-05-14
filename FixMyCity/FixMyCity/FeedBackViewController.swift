import UIKit

class FeedBackViewController: UIViewController {

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
//        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "CircularStd-Bold", size: 24)!,  NSForegroundColorAttributeName: titleColor]
//    
        let attributedTitle = NSAttributedString(string: "STÄNG",
                                                           attributes: [NSForegroundColorAttributeName : UIColor.whiteColor(), NSFontAttributeName: UIFont(name: "CircularStd-Book", size: 24)!])
        closeButton.setAttributedTitle(attributedTitle, forState: .Selected)
        closeButton.setAttributedTitle(attributedTitle, forState: .Normal)
        
        headerLabel.font = UIFont(name: "CircularStd-Book", size: 24)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    @IBAction func closeMe(sender: AnyObject) {
        dismissViewControllerAnimated(false, completion: nil)
    }
}
