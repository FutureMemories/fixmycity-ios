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
}