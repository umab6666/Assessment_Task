//
//  MainViewModal.swift
//  AssessmentTask
//
//  Created by Uma B on 12/02/19.
//  Copyright © 2019 Uma B. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol MainViewModalProtocol {
    var contentArray : [Category]? { get }
    var remoteDataSource: RemoteDataSourceProtocol! { get set}
    var  title : String? { get }
    func getImageDataFromServer(completionHandler: @escaping (_ isSuccess:Bool , _ errorMsg:String?)->Void)
}

class MainViewModal: MainViewModalProtocol {
    var contentArray: [Category]?
    var title: String?
    
    var remoteDataSource: RemoteDataSourceProtocol!
    init(dataSourceProtocol: RemoteDataSourceProtocol) {
        remoteDataSource = dataSourceProtocol
    }
    
    func getImageDataFromServer(completionHandler: @escaping (Bool, String?) -> Void) {
        SVProgressHUD.show()
        remoteDataSource.getAllCategories(successHandler: { (catogories, title) in
            self.contentArray = catogories
            self.title = title
            completionHandler(true,nil)
            SVProgressHUD.dismiss()
        }) { (error) in
            completionHandler(false,error)
            SVProgressHUD.dismiss()
        }
    }
}
