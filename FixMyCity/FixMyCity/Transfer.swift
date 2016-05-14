import UIKit
import Alamofire
import SwiftyJSON
import PromiseKit
import Foundation

class Transfer {
    let rootURL = "http://192.81.222.241"
    func getJsonPromise(url:String, parameters: [String : AnyObject]) -> Promise<JSON> {
        return Promise{ fulfill, reject in
            let longURL = rootURL + "/issues/"
            
            Alamofire.request(.GET, longURL, parameters: parameters)
                .responseJSON { response in
                    switch response.result {
                    case .Success(let payload):
                        fulfill(JSON(payload))
                    case .Failure(let error):
                        reject(error)
                    }
            }
        }
    }
    
    func postJson(url:String, parameters: [String : AnyObject], completionClosure:(responseString: NSHTTPURLResponse) -> ()) {
        
        let longURL = rootURL + "/issues/"
        let params = ["type" : "Problem", "category" : "Badplats", "long" : 99.2, "lat": 11.1, "image":NSData()]
        let testHeaders = ["Content-Type" : "application/vnd.skf.most.deviation+json;version=1" ]
        request(.POST, longURL, parameters: params, encoding: .URL, headers: testHeaders).response { (request, response, whatever, error) -> Void in
            print(response)
        }
        
        
    }
    
    
}