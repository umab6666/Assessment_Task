//
//  Alert.swift
//  AssessmentTask
//
//  Created by Uma B on 12/02/19.
//  Copyright © 2019 Uma B. All rights reserved.
//

import UIKit

class Alert: NSObject {
    
    class func showApiErrorAlert(message:String) {
        let alert = UIAlertController(title: "Error" , message: message , preferredStyle: .alert)
        let okAction = (UIAlertAction(title: "OK", style: .default, handler: nil))
        alert.addAction(okAction)
        UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
    }

}
