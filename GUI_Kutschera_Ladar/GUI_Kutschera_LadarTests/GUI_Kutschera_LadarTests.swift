//
//  GUI_Kutschera_LadarTests.swift
//  GUI_Kutschera_LadarTests
//
//  Created by Philipp Ladar on 01.02.19.
//  Copyright © 2019 hattitatti. All rights reserved.
//

import XCTest
@testable import GUI_Kutschera_Ladar

class GUI_Kutschera_LadarTests: XCTestCase {
  func testExample() {
    //GIVEN
    let csv = "testValue;That;Is;Written;In;csv"

    //WHEN
    let parsed = csv.parseCsv()

    //THEN
    XCTAssertEqual(parsed, ["testValue", "That", "Is", "Written", "In", "csv"])
  }

}
