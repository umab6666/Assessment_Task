//
//  MainViewModal.swift
//  AssessmentTask
//
//  Created by Uma B on 12/02/19.
//  Copyright © 2019 Uma B. All rights reserved.
//

import UIKit

protocol MainViewModalProtocol {
    var contentArray : [Category]? { get }
    var  title : String? { get }
    func getImageDataFromServer(completionHandler: @escaping (_ isSuccess:Bool , _ errorMsg:String)->Void)
}

class MainViewModal: MainViewModalProtocol {
    var contentArray: [Category]?
    var title: String?
    
    func getImageDataFromServer(completionHandler: @escaping (Bool, String) -> Void) {
        WebService.parseData(urlStr: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json", parameters: nil, method: .GET, successHandler: { (result) in
            self.contentArray?.removeAll()
            if let dict = result as? [String:Any]{
                self.title = dict[""] as? String ?? "title"
                if let rowsArr = dict["rows"] as? [[String:Any]]{
                    for row in rowsArr{
                        self.contentArray?.append(Category(dict: row))
                    }
                }
            }
            completionHandler(true,"")
        }) { (errMsg) in
            completionHandler(false,errMsg)
        }
    }
}
