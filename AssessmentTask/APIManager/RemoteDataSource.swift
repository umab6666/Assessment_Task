//
//  RemoteDataSource.swift
//  AssessmentTask
//
//  Created by Uma B on 12/02/19.
//  Copyright © 2019 Uma B. All rights reserved.
//

import UIKit
protocol RemoteDataSourceProtocol {
    func getAllCategories(successHandler: @escaping ([Category], String) -> Void,failureHandler: @escaping (String?) -> Void)
}
class RemoteDataSource: RemoteDataSourceProtocol {

    func getAllCategories(successHandler: @escaping ([Category], String) -> Void,failureHandler: @escaping (String?) -> Void) {
        WebService.parseData(urlStr: CONTENT_URL, parameters: nil, method: .GET, successHandler: { (result) in
            var contentArray = [Category]()
            if let dict = result as? [String:Any] {
                let headerTitle = dict["title"] as? String ?? ""
                if let rowsArr = dict["rows"] as? [[String:Any]]{
                    for row in rowsArr{
                        if let catagory = Category(dict: row) {
                            contentArray.append(catagory)
                        }
                    }
                }
                successHandler(contentArray,headerTitle)
            } else {
                failureHandler(INVALID_RESPONSE_ERRORMESSAGE)
            }
        }) { (errMsg) in
            failureHandler(errMsg)
        }
    }
}
