

import UIKit

protocol FeedbackMenuDelegate {
    func menuItemTapped(num: Int)
}

class CollectionViewDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var delegate : FeedbackMenuDelegate!
    let reuseIdentifier = "Cell"
    
    var items = ["Förslag","Fråga","Beröm","Problem","Skada","Renhållning"]
    var images = ["Forslag","Fraga","Berom","Problem","Trasigt","Renhallning"]
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var cell : FeedbackMenuCell
        
        cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! FeedbackMenuCell
//        let buttonImage = TempMachineDetailMenuButtonImages.allButtons[indexPath.row].rawValue
//        let buttonTitle = items[indexPath.row].rawValue
        
        cell.imageView.image = UIImage(named: images[indexPath.row])
        cell.buttonTitle.text = items[indexPath.row]
        cell.tag = indexPath.row
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
     return true
     }
     */
    
    
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
    func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return true
    }
    
    func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
        
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let row = indexPath.row
        delegate.menuItemTapped(row)
    }
 
     func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        cell.alpha = 0
        cell.layer.transform = CATransform3DMakeScale(0.5, 0.5, 0.5)
//        UIView.animateWithDuration(0.2, animations: { () -> Void in
//            cell.alpha = 1
//            cell.layer.transform = CATransform3DScale(CATransform3DIdentity, 1, 1, 1)
//        })
//        
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.2, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            cell.alpha = 1
            cell.layer.transform = CATransform3DScale(CATransform3DIdentity, 1, 1, 1)

            }) { (true) in
                
        }
    }
}