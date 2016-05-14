import UIKit

protocol CommentViewDelegate {
    func commentsClose(comment : String)
}

class CommentViewController: UIViewController {
    var delegate : CommentViewDelegate!
    
    @IBOutlet weak var commentField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentField.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func closeMe(sender: AnyObject) {
        delegate.commentsClose("")
        dismissViewControllerAnimated(false, completion: nil)
    }
    
    @IBAction func checkTapped(sender: AnyObject) {
        delegate.commentsClose(commentField.text)
        dismissViewControllerAnimated(false, completion: nil)
    }
}
