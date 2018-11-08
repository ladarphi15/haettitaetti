//
// Created by Philipp Ladar on 2018-11-08.
// Copyright (c) 2018 hattitatti. All rights reserved.
//

extension String {
  func parseCsv() -> [[String]] {
    return CsvParser.parse(self)
  }
}
