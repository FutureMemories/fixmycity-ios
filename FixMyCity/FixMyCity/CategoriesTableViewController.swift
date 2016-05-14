import UIKit

protocol CategoriesDelegate {
    func categorySelected(cat : String)
}

class CategoriesTableViewController: UIViewController, CategoriesDatasourceDelegate {
    var catProblem = [String]()
    var catSkada = [String]()
    var catRenhallning = [String]()
    var dataSource : CategoriesDatasource = CategoriesDatasource()
    var delegate : CategoriesDelegate!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        catProblem = ["Badplats",
                      "Belysning",
                      "Buller",
                      "Cykelbana",
                      "Gallerbrunn",
                      "Gatuunderhåll",
                      "Gräs",
                      "Hål i gatan",
                      "Klotter",
                      "Lekplats",
                      "Nedskräpning",
                      "Offentliga toaletter",
                      "Ogräs och sly",
                      "Parkering",
                      "Papperskorgar",
                      "Sand och grus",
                      "Skyltar och vägmärken",
                      "Trafiksignaler",
                      "Träd och buskar",
                      "Vinterväghållning",
                      "Vägarbeten",
                      "Annat problem"]
        
        catSkada = ["Belysning",
                    "Gallerbrunn",
                    "Hål i gatan",
                    "Klotter",
                    "Lekplats",
                    "Offentliga toaletter",
                    "Skyltar och vägmärken",
                    "Trafiksignaler",
                    "Träd och buskar"]
        
        catRenhallning = ["Klotter",
                          "Badplats",
                          "Cykelbana",
                          "Lekplats",
                          "Offentliga toaletter",
                          "Parkering",
                          "Papperskorgar"]
        
        dataSource = tableView.dataSource as! CategoriesDatasource
        dataSource.delegate = self
        dataSource.items = catProblem
    }
    
    func selectedCategory(cat : String) {
        delegate.categorySelected(cat)
        dismissViewControllerAnimated(false, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
