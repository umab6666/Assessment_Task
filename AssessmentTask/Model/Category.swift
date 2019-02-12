//
//  Category.swift
//  AssessmentTask
//
//  Created by Uma B on 12/02/19.
//  Copyright © 2019 Uma B. All rights reserved.
//
import Foundation

class Category: NSObject {
    
    var imageurl : URL?
    var titleString = ""
    var descriptionString = ""
    
    init?(dict:[String:Any]) {
        let title = dict["title"] as? String ?? ""
        let desc = dict["description"] as? String ?? ""
        let urlString = dict["imageHref"] as? String ?? ""
        if title.isEmpty && desc.isEmpty && urlString.isEmpty {
            return nil
        }
        self.titleString =  title
        self.descriptionString =  desc
        self.imageurl = URL(string:urlString)
    }
}
