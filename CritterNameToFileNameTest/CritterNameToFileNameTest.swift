//
//  CritterNameToFileNameTest.swift
//  CritterNameToFileNameTest
//
//  Created by Dennis Kao on 2020-05-09.
//  Copyright © 2020 Dennis Kao. All rights reserved.
//

import XCTest
@testable import Critterpedia

class CritterNameToFileNameTest: XCTestCase {

    var spaceNameCritter: Critter!
    var apostropheNameCritter: Critter!
    var dashNameCritter: Critter!
    var allEscapeCharNameCritter: Critter!

    override func setUp() {
        super.setUp()
        spaceNameCritter = Critter(name: "Caspian Carp", location: "River", price: 99, timesText: "2AM - 9PM", times: [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21], northernMonths: [1, 2, 3, 4, 5, 6], southernMonths: [7, 8, 9])
        apostropheNameCritter = Critter(name: "QueenAlexandra'sBirdwing", location: "River", price: 99, timesText: "2AM - 9PM", times: [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21], northernMonths: [1, 2, 3, 4, 5, 6], southernMonths: [7, 8, 9])
        dashNameCritter = Critter(name: "Long-hornedBeetle", location: "River", price: 99, timesText: "2AM - 9PM", times: [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21], northernMonths: [1, 2, 3, 4, 5, 6], southernMonths: [7, 8, 9])
        allEscapeCharNameCritter = Critter(name: "Queen Alexandra's Long-horned Birdwing", location: "River", price: 99, timesText: "2AM - 9PM", times: [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21], northernMonths: [1, 2, 3, 4, 5, 6], southernMonths: [7, 8, 9])
    }

    override func tearDown() {
        spaceNameCritter = nil
        apostropheNameCritter = nil
        dashNameCritter = nil
        allEscapeCharNameCritter = nil
        super.tearDown()
    }

    func testRenaming() {
        XCTAssert(spaceNameCritter.imageName == "caspiancarp")
        XCTAssert(spaceNameCritter.iconName == "icon-caspiancarp")

        XCTAssert(apostropheNameCritter.imageName == "queenalexandrasbirdwing")
        XCTAssert(apostropheNameCritter.iconName == "icon-queenalexandrasbirdwing")

        XCTAssert(dashNameCritter.imageName == "longhornedbeetle")
        XCTAssert(dashNameCritter.iconName == "icon-longhornedbeetle")

        XCTAssert(allEscapeCharNameCritter.imageName == "queenalexandraslonghornedbirdwing")
        XCTAssert(allEscapeCharNameCritter.iconName == "icon-queenalexandraslonghornedbirdwing")
    }
}
