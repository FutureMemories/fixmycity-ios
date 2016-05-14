import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(UIFont.familyNames())
    }

    override func viewDidAppear(animated: Bool) {
        let titleColor = UIColor(red: 33/255, green: 150/255, blue: 243/255, alpha: 1)
        self.navigationController?.navigationBar.topItem?.title = "FixMyCity"
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "CircularStd-Bold", size: 24)!,  NSForegroundColorAttributeName: titleColor]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func addFeedback(sender: AnyObject) {
        performSegueWithIdentifier("feedbackSegue", sender: self)
    }
}

