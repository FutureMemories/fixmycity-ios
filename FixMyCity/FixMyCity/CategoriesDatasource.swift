

import UIKit

protocol CategoriesDatasourceDelegate: class {
    func selectedCategory(cat: String)
}

class CategoriesDatasource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    let cellIdentifier = "Cell"
    var items = [String]()
    weak var delegate:CategoriesDatasourceDelegate!
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let row = indexPath.row
        var cell : UITableViewCell
        
        cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        
        cell.textLabel?.text = items[row]
        cell.textLabel?.textColor = UIColor.whiteColor()
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        let row = indexPath.row
        delegate.selectedCategory(items[row])
    }
    
}
