//
//  Category.swift
//  AssessmentTask
//
//  Created by Uma B on 12/02/19.
//  Copyright © 2019 Uma B. All rights reserved.
//


struct Category {
    
    var imageUrlString = ""
    var titleString = ""
    var descriptionString = ""
    
    init(dict:[String:Any]) {
        self.titleString =  dict["title"] as? String ?? ""
        self.descriptionString =  dict["description"] as? String ?? ""
        self.imageUrlString =  dict["imageHref"] as? String ?? ""
    }
}
