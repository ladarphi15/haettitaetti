//
//  LottoDrawExtensions.swift
//  GUI_Kutschera_Ladar
//
//  Created by Philipp Ladar on 09.11.18.
//  Copyright © 2018 hattitatti. All rights reserved.
//

extension LottoDrawEntity {
  func match(other: LottoDrawEntity) -> LottoDrawMatch {
    let compResult1 = compareWithAllNumbers(numberToCompare: self.number1, other)
    let compResult2 = compareWithAllNumbers(numberToCompare: self.number2, other)
    let compResult3 = compareWithAllNumbers(numberToCompare: self.number3, other)
    let compResult4 = compareWithAllNumbers(numberToCompare: self.number4, other)
    let compResult5 = compareWithAllNumbers(numberToCompare: self.number5, other)
    let compResult6 = compareWithAllNumbers(numberToCompare: self.number6, other)

    let result = LottoDrawMatch()
    if (compResult1 != nil) {
      result.number1MatchTo = compResult1
    }
    if (compResult2 != nil) {
      result.number1MatchTo = compResult2
    }
    if (compResult3 != nil) {
      result.number1MatchTo = compResult3
    }
    if (compResult4 != nil) {
      result.number1MatchTo = compResult4
    }
    if (compResult5 != nil) {
      result.number1MatchTo = compResult5
    }
    if (compResult6 != nil) {
      result.number1MatchTo = compResult6
    }
    return result
  }
}

func compareWithAllNumbers(numberToCompare: Int16, _ other: LottoDrawEntity) -> Int? {
  if (numberToCompare == other.number1) {
    return 1
  }
  if (numberToCompare == other.number2) {
    return 2
  }
  if (numberToCompare == other.number3) {
    return 3
  }
  if (numberToCompare == other.number4) {
    return 4
  }
  if (numberToCompare == other.number5) {
    return 5
  }
  if (numberToCompare == other.number6) {
    return 6
  }
  if (numberToCompare == other.numberZz) {
    return 7
  }
  return nil
}
