//
//  CritterParsingTests.swift
//  CritterParsingTests
//
//  Created by Dennis Kao on 2020-05-09.
//  Copyright © 2020 Dennis Kao. All rights reserved.
//

import XCTest
@testable import Critterpedia

class CritterParsingTests: XCTestCase {
    
    var parser: CritterParser!
    var passingJSONData: Dictionary<String, Any>!
    var missingMonthArrayJSONData: Dictionary<String, Any>!
    var invalidKeyJSONData: Dictionary<String, Any>!
    
    override func setUp() {
        super.setUp()
        parser = CritterParser()
        passingJSONData = [
            "name": "Crucian Carp",
            "location": "River",
            "price": 160,
            "times": [
                "array" : [0, 1, 2, 3, 4,],
                "text": "All day"
            ],
            "months": [
                "northern": [
                    "array": [ 1, 2, 3, 12 ],
                    "text": "Year Round"
                ],
                "southern": [
                    "array": [ 9, 10, 11, 12],
                    "text": "Year Round"
                ]
            ]
        ]
        missingMonthArrayJSONData = [
            "name": "Crucian Carp",
            "location": "River",
            "price": 160,
            "times": [
                "array" : [0, 1, 2, 3, 4,],
                "text": "All day"
            ],
            "months": [
                "northern": [
                    "text": "Year Round"
                ],
                "southern": [
                    "array": [ 9, 10, 11, 12],
                    "text": "Year Round"
                ]
            ]
        ]
        invalidKeyJSONData = [
           "name": "Crucian Carp",
           "location": "River",
           "price": 160,
           "times": [
               "array" : [0, 1, 2, 3, 4,],
               "text": "All day"
           ],
           "months": [
               "Northern": [
                    "array": [ 1, 2, 3, 12 ],
                    "text": "Year Round"
               ],
               "southern": [
                    "array": [ 9, 10, 11, 12],
                    "text": "Year Round"
               ]
           ]
       ]
    }
    
    override func tearDown() {
        parser = nil
        super.tearDown()
    }
    
    func testParsing() {
        
        let passingCritter = CritterParser.parse(passingJSONData)
        
        XCTAssert(passingCritter != nil)
        XCTAssert(passingCritter!.name == "Crucian Carp")
        XCTAssert(passingCritter!.location == "River")
        XCTAssert(passingCritter!.price == 160)
        XCTAssert(passingCritter!.times == "All day")
        XCTAssert(passingCritter!.northernMonths == [ 1, 2, 3, 12 ])
        XCTAssert(passingCritter!.southernMonths == [ 9, 10, 11, 12 ])
        
        XCTAssert(CritterParser.parse(missingMonthArrayJSONData) == nil)
        XCTAssert(CritterParser.parse(invalidKeyJSONData) == nil)
    }
}
