//
//  GUI_Kutschera_LadarUITests.swift
//  GUI_Kutschera_LadarUITests
//
//  Created by Philipp Ladar on 31.01.19.
//  Copyright © 2019 hattitatti. All rights reserved.
//

import XCTest

class GUI_Kutschera_LadarUITests: XCTestCase {
  var app: XCUIApplication!

  override func setUp() {
    continueAfterFailure = false
    app = XCUIApplication()
    app.launch()
  }

  func testWinScreenIsShown() {
    app.pickerWheels.allElementsBoundByIndex[0].adjust(toPickerWheelValue: "3")
    app.pickerWheels.allElementsBoundByIndex[1].adjust(toPickerWheelValue: "15")
    app.pickerWheels.allElementsBoundByIndex[2].adjust(toPickerWheelValue: "23")
    app.pickerWheels.allElementsBoundByIndex[3].adjust(toPickerWheelValue: "26")
    app.pickerWheels.allElementsBoundByIndex[4].adjust(toPickerWheelValue: "38")
    app.pickerWheels.allElementsBoundByIndex[5].adjust(toPickerWheelValue: "40")
    app.buttons["haettiButton"].tap()

    XCTAssert(app.staticTexts["Du hast folgende Zahlen gezogen"].isHittable)

  }

  func testLoseScreenIsShown() {
    app.pickerWheels.allElementsBoundByIndex[0].adjust(toPickerWheelValue: "19")
    app.pickerWheels.allElementsBoundByIndex[1].adjust(toPickerWheelValue: "2")
    app.pickerWheels.allElementsBoundByIndex[2].adjust(toPickerWheelValue: "10")
    app.pickerWheels.allElementsBoundByIndex[3].adjust(toPickerWheelValue: "12")
    app.pickerWheels.allElementsBoundByIndex[4].adjust(toPickerWheelValue: "14")
    app.pickerWheels.allElementsBoundByIndex[5].adjust(toPickerWheelValue: "19")
    app.buttons["haettiButton"].tap()

    XCTAssert(app.staticTexts["Leider verloren :("].isHittable)

  }

}
