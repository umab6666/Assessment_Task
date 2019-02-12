//
//  WebService.swift
//  AssessmentTask
//
//  Created by Uma B on 12/02/19.
//  Copyright © 2019 Uma B. All rights reserved.
//

import UIKit
import SVProgressHUD


enum MethodType {
    case GET,POST,PUT,DELETE,PATCH
    
    func getMethodName() -> String {
        switch self {
        case .GET:
            return "GET"
        case .POST:
            return "POST"
        case .PUT:
            return "PUT"
        case .DELETE:
            return "DELETE"
        case .PATCH:
            return "PATCH"
        }
    }
}
typealias successBlock = (_ result:Any) -> Void
typealias failureBlock = (_ errMsg:String) -> Void

class WebService: NSObject {
    class func parseData(urlStr:String,parameters:Any?,method:MethodType ,successHandler:@escaping successBlock,failureHandler:@escaping failureBlock){
      
        if !ReachabilityHandler.shared.checkReachability(){
            failureHandler(NO_NETWORK_ERRORMESSAGE)
            return
        }
        guard let urlStr = urlStr.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed), let url = URL(string: urlStr) else{
             failureHandler(INVALID_URL_ERRORMESSAGE)
            return
        }
        
        var request = URLRequest(url: url)
        request.cachePolicy = .reloadIgnoringCacheData
        request.httpMethod = method.getMethodName()
        self.callWebservice(request: request) { (result, errMsg) in
            if errMsg == nil {
                successHandler(result as Any)
            }else{
                failureHandler(errMsg! as String)
            }
        }
    }
    private
    class func callWebservice(request:URLRequest,completionBlock:@escaping (Any?,String?) -> () ){
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, err) in
            if err == nil {
                let responseString = String(data: data!, encoding: String.Encoding.ascii)
                let responseData = responseString?.data(using: String.Encoding.utf8)
                do {
                    let result = try JSONSerialization.jsonObject(with: responseData!, options: .allowFragments)
                    DispatchQueue.main.async {
                        completionBlock(result,nil)
                    }
                }
                catch let JSONError as NSError{
                    completionBlock(nil,JSONError.localizedDescription)
                }
            }else{
                completionBlock(nil,err?.localizedDescription)
            }
            
            }.resume()
    }

}
