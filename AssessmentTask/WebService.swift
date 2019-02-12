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
            failureHandler(networkConnectionError)
            return
        }
        guard let urlStr = urlStr.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed), let url = URL(string: urlStr) else{
             failureHandler(invalidURLErrMsg)
            return
        }
        
        var request = URLRequest(url: url)
        request.cachePolicy = .reloadIgnoringCacheData
        request.httpMethod = method.getMethodName()
        request.setValue("text/plain; charset=ISO-8859-1", forHTTPHeaderField: "Content-Type")
        
        if(parameters != nil){
            request.httpBody = self.convertParametersToData(parms: parameters! as AnyObject) as Data?
        }
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
    
    private
    class func convertParametersToData(parms:AnyObject) -> NSData?{
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parms, options: JSONSerialization.WritingOptions.prettyPrinted)
            let jsonStr = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)
            return jsonStr!.data(using: String.Encoding.utf8.rawValue, allowLossyConversion: false) as NSData?
        }catch let err as NSError{
            print("JSON ERROR\(err.localizedDescription)")
        }
        catch {
            // Catch any other errors
        }
        return nil
    }
}
