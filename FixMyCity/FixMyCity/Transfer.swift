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
    
    func postJson(image: UIImage, parameters: [String : AnyObject], completionClosure:(responseString: NSHTTPURLResponse) -> ()) {
        
        let longURL = rootURL + "/issues/"
       /* let params = ["type" : "Problem", "category" : "Badplats", "long" : 99.2, "lat": 11.1, "image":NSData()]
        let testHeaders = ["Content-Type" : "application/vnd.skf.most.deviation+json;version=1" ]
        request(.POST, longURL, parameters: params, encoding: .URL, headers: testHeaders).response { (request, response, whatever, error) -> Void in
            print(response)
        }*/
        
        let imageData: NSData = UIImagePNGRepresentation(image)!
        
        upload(.POST, longURL, multipartFormData: { formdata in
            
            formdata.appendBodyPart(data: "Problem".dataUsingEncoding(NSUTF8StringEncoding)!, name: "type")
            formdata.appendBodyPart(data: "Badplats".dataUsingEncoding(NSUTF8StringEncoding)!, name: "category")
            formdata.appendBodyPart(data: "11.2".dataUsingEncoding(NSUTF8StringEncoding)!, name: "long")
            formdata.appendBodyPart(data: "99.2".dataUsingEncoding(NSUTF8StringEncoding)!, name: "lat")
            formdata.appendBodyPart(data: imageData , name: "image")
            
            
            }) { encodingResult in
                switch encodingResult {
                case .Success(let upload, _, _):
                    
                    upload.responseJSON { err in
                    print("sucess")
                    }
                case .Failure:
                    print("fail")
                }
                
                print(encodingResult)
                print("asdas")
        }
        
    }
    
    
}