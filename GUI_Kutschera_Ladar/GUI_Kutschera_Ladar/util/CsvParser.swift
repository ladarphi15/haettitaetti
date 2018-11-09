//
// Created by Philipp Ladar on 2018-11-08.
// Copyright (c) 2018 hattitatti. All rights reserved.
//

class CsvParser: LottoParser {
  static func parse(_ data: String) -> [String] {
      return data.split(separator: ";", omittingEmptySubsequences: false).map{ substr -> String in return String(substr)}
  }
}
