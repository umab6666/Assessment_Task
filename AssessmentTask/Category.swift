//
//  Category.swift
//  AssessmentTask
//
//  Created by Uma B on 12/02/19.
//  Copyright © 2019 Uma B. All rights reserved.
//
import Foundation

struct Category {
    
    var imageurl : URL?
    var titleString = ""
    var descriptionString = ""
    
    init?(dict:[String:Any]) {
        self.titleString =  dict["title"] as? String ?? ""
        self.descriptionString =  dict["description"] as? String ?? ""
        let urlString = dict["imageHref"] as? String ?? ""
        self.imageurl = URL(string:urlString)
        if self.titleString.isEmpty && self.descriptionString.isEmpty && urlString.isEmpty {
            return nil
        }
    }
}
