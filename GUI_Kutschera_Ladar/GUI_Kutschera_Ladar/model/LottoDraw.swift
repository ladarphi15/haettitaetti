//
// Created by Philipp Ladar on 2018-11-08.
// Copyright (c) 2018 hattitatti. All rights reserved.
//

enum LottoDrawException: Error {
  case invalidArguments
}

class LottoDraw {
  var number1: Int
  var number2: Int
  var number3: Int
  var number4: Int
  var number5: Int
  var number6: Int

  init(_ number1: Int,
       _ number2: Int,
       _ number3: Int,
       _ number4: Int,
       _ number5: Int,
       _ number6: Int) throws {

    self.number1 = number1
    guard number1 <= 45 && number1 >= 1 else {
      throw LottoDrawException.invalidArguments
    }

    self.number2 = number2
    guard number2 <= 45 && number2 >= 1 else {
      throw LottoDrawException.invalidArguments
    }

    self.number3 = number3
    guard number3 <= 45 && number3 >= 1 else {
      throw LottoDrawException.invalidArguments
    }

    self.number4 = number4
    guard number4 <= 45 && number4 >= 1 else {
      throw LottoDrawException.invalidArguments
    }

    self.number5 = number5
    guard number5 <= 45 && number5 >= 1 else {
      throw LottoDrawException.invalidArguments
    }

    self.number6 = number6
    guard number6 <= 45 && number6 >= 1 else {
      throw LottoDrawException.invalidArguments
    }

  }
}

func ==(left: LottoDraw, right: LottoDraw) -> Bool {
  return left.number1 == right.number1
      && left.number2 == right.number2
      && left.number3 == right.number3
      && left.number4 == right.number4
      && left.number5 == right.number5
      && left.number6 == right.number6
}
