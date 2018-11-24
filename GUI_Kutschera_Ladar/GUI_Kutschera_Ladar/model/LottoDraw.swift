//
// Created by Philipp Ladar on 2018-11-08.
// Copyright (c) 2018 hattitatti. All rights reserved.
//

import CoreData
import UIKit

enum LottoDrawException: Error {
  case invalidArguments
}

class LottoDraw {
  var numbers: Array<Int>?
  init(){}
}

func convertCsvAndSaveToDB(csv: String) {
  let appDelegate = UIApplication.shared.delegate as! AppDelegate
  let context = appDelegate.persistentContainer.viewContext
  let entity = NSEntityDescription.entity(forEntityName: "LottoDrawEntity", in: context)
  let lottoDraw = NSManagedObject(entity: entity!, insertInto: context)
  let parsedLottoDraw = csv.parseCsv()
  do {
   try lottoDraw.setValue(convertStringToLottoNumber(parsedLottoDraw[0]), forKey: "number1")
   try lottoDraw.setValue(convertStringToLottoNumber(parsedLottoDraw[1]), forKey: "number2")
   try lottoDraw.setValue(convertStringToLottoNumber(parsedLottoDraw[2]), forKey: "number3")
   try lottoDraw.setValue(convertStringToLottoNumber(parsedLottoDraw[3]), forKey: "number4")
   try lottoDraw.setValue(convertStringToLottoNumber(parsedLottoDraw[4]), forKey: "number5")
   try lottoDraw.setValue(convertStringToLottoNumber(parsedLottoDraw[5]), forKey: "number6")
   try lottoDraw.setValue(convertStringToLottoNumber(parsedLottoDraw[0]), forKey: "numberZz")
  } catch LottoDrawException.invalidArguments {
    print("Cannot convert the lotto draw number. Something went wrong!")
  } catch {
    print("Unknown Error")
  }
}

// TODO: guard function for lottodraw inputs
func convertStringToLottoNumber(_ numberAsString: String) throws -> Int16 {
  let number = Int16(numberAsString) ?? 0
  guard number <= 45 && number >= 1 else {
    throw LottoDrawException.invalidArguments
  }
  return number
}
