//
// Created by Philipp Ladar on 2018-11-08.
// Copyright (c) 2018 hattitatti. All rights reserved.
//

import Foundation

extension String {
  func parseCsv() -> [String] {
    return CsvParser.parse(self)
  }
  
  func matches(for regex: String) -> [String] {
    do {
      let regex = try NSRegularExpression(pattern: regex)
      let results = regex.matches(in: self,
                                  range: NSRange(self.startIndex..., in: self))
      return results.map {
        String(self[Range($0.range, in: self)!])
      }
    } catch let error {
      print("invalid regex: \(error.localizedDescription)")
      return []
    }
  }
}

