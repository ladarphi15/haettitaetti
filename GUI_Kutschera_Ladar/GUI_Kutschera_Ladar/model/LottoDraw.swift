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
  lottoDraw.setValue(Int16(parsedLottoDraw[0])!, forKey: "number1")
  lottoDraw.setValue(Int16(parsedLottoDraw[1])!, forKey: "number2")
  lottoDraw.setValue(Int16(parsedLottoDraw[2])!, forKey: "number3")
  lottoDraw.setValue(Int16(parsedLottoDraw[3])!, forKey: "number4")
  lottoDraw.setValue(Int16(parsedLottoDraw[4])!, forKey: "number5")
  lottoDraw.setValue(Int16(parsedLottoDraw[5])!, forKey: "number6")
  lottoDraw.setValue(Int16(parsedLottoDraw[0])!, forKey: "numberZz")
}

// TODO: guard function for lottodraw inputs
