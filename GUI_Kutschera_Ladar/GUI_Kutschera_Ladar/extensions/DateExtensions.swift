//
// Created by Philipp Ladar on 2019-01-30.
// Copyright (c) 2019 hattitatti. All rights reserved.
//

import Foundation

extension Date {

  func getYear() -> Int {
    let calendar = Calendar.current
    return calendar.component(.year, from: self)
  }

  func getDay() -> Int {
    let calendar = Calendar.current
    return calendar.component(.day, from: self)
  }

  func getMonth() -> Int {
    let calendar = Calendar.current
    return calendar.component(.month, from: self)
  }
}
