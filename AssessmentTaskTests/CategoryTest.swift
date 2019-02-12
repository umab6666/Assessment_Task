//
//  CategoryTest.swift
//  AssessmentTaskTests
//
//  Created by Uma B on 12/02/19.
//  Copyright © 2019 Uma B. All rights reserved.
//

import XCTest
@testable import AssessmentTask
class CategoryTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testForCategoryObjectSucess(){
        let dict = [
            "title":"Beavers",
            "description":"Beavers are second only to humans in their ability to manipulate and change their environment. They can measure up to 1.3 metres long. A group of beavers is called a colony",
            "imageHref":"http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg"
        ]
        XCTAssertTrue(Category(dict: dict) != nil)
    }
    
    func testForCategoryObjectFail() {
        let dict = [
            "title":"",
            "description":"",
            "imageHref":""
            ]
        XCTAssertNil(Category(dict: dict))

    }
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
