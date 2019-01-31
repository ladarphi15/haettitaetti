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
  var date: Date
  var numbers: Array<Int16>?
  var zz: Int16
  var amount: String

  init(date: Date, numbers: Array<Int16>, zz: Int16, amount: String) {
    self.date = date
    self.numbers = numbers
    self.zz = zz
    self.amount = amount
  }
}

let appDelegate = UIApplication.shared.delegate as! AppDelegate
let context = appDelegate.persistentContainer.viewContext

func convertCsvAndSaveToDB(csv: String, date: Date, amount: String) {
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
    try lottoDraw.setValue(convertStringToLottoNumber(parsedLottoDraw[7]), forKey: "numberZz")
    lottoDraw.setValue(amount, forKey: "amount")
    lottoDraw.setValue(date, forKey: "date")
  } catch LottoDrawException.invalidArguments {
    print("Cannot convert the lotto draw number. Something went wrong!")
  } catch {
    print("Unknown Error")
  }

  do {
    try context.save()
  } catch {
    print("Save did not work")
  }
}

func getLottoDraws() -> [LottoDraw] {
  var allDraws: [LottoDraw] = []
  let request = NSFetchRequest<NSFetchRequestResult>(entityName: "LottoDrawEntity")
  request.returnsObjectsAsFaults = false
  do {
    let result = try context.fetch(request)
    for data in result as! [NSManagedObject] {
      var draws: [Int16] = []
      draws.append(data.value(forKey: "number1") as? Int16 ?? 0)
      draws.append(data.value(forKey: "number2") as? Int16 ?? 0)
      draws.append(data.value(forKey: "number3") as? Int16 ?? 0)
      draws.append(data.value(forKey: "number4") as? Int16 ?? 0)
      draws.append(data.value(forKey: "number5") as? Int16 ?? 0)
      draws.append(data.value(forKey: "number6") as? Int16 ?? 0)
      let zz = data.value(forKey: "numberZz") as? Int16 ?? 0
      let date = data.value(forKey: "date") as! Date
      let amount = data.value(forKey: "amount") as? String ?? ""
      allDraws.append(LottoDraw(date: date, numbers: draws, zz: zz, amount: amount))
    }
  } catch {
    print("Failed")
  }
  return allDraws
}

func convertStringToLottoNumber(_ numberAsString: String) throws -> Int16 {
  let number = Int16(numberAsString) ?? 0
  guard number <= 45 && number >= 1 else {
    throw LottoDrawException.invalidArguments
  }
  return number
}
