//
//  MockDataSource.swift
//  AssessmentTask
//
//  Created by Uma B on 12/02/19.
//  Copyright © 2019 Uma B. All rights reserved.
//

import UIKit

class MockDataSource: RemoteDataSourceProtocol {
    
    var responseForSuccess = true
    
    func getAllCategories(successHandler: @escaping ([Category], String) -> Void, failureHandler: @escaping (String?) -> Void) {
        if responseForSuccess {
            successHandler([Category](),"Title")
        }else {
            failureHandler("failed")
        }
    }
}
