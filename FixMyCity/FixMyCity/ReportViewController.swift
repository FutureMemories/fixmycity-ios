import UIKit

protocol ReportViewDelegate {
    func closeReport()
}

class ReportViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate,CategoriesDelegate,CommentViewDelegate {
    var menuItem : MenuItem!
    var delegate : ReportViewDelegate!
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var thumb: UIImageView!
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var catLabel: UILabel!
    
    @IBOutlet weak var cameraButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        header.font = UIFont(name: "CircularStd-Book", size: 24)
        
        icon.image = UIImage(named: menuItem.imageName)
        header.text = menuItem.header
        
        imagePicker.delegate = self
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

    @IBAction func showComment(sender: AnyObject) {
        self.view.hidden = true
        performSegueWithIdentifier("showCommentSegue", sender: self)
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
    
    func commentsClose(comment : String) {
        self.view.hidden = false
        showUI()
    }
    
    @IBAction func showCamera(sender: AnyObject) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        imagePicker.cameraCaptureMode = .Photo
        presentViewController(imagePicker, animated: true) { () -> Void in
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showCatagoriesSegue" {
            let dest = segue.destinationViewController as! CategoriesTableViewController
            dest.delegate = self
        } else if segue.identifier == "showCommentSegue" {
            let dest = segue.destinationViewController as! CommentViewController
            dest.delegate = self
            
        }
    }
    
    // MARK: - Picker delegates
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        cameraButton.imageView?.image = image
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        dismissViewControllerAnimated(true) {
            let image = info[UIImagePickerControllerOriginalImage] as! UIImage
            self.thumb.image = image
//            self.cameraButton.setBackgroundImage(image, forState: .Normal)
        }
    }
    

}
