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
        let url = URL(string: urlStr.replacingOccurrences(of: " ", with: "%20"))
        var request = URLRequest(url: url!)
        request.cachePolicy = .reloadIgnoringCacheData
        request.httpMethod = method.getMethodName()
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
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
                do {
                    let result = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
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
