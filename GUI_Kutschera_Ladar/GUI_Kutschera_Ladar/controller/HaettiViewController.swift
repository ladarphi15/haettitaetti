//
//  HaettiViewController.swift
//  GUI_Kutschera_Ladar
//
//  Created by Stefan Kutschera and Philipp Ladar on 07.11.18.
//  Copyright © 2018 hattitatti. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

  @IBOutlet weak var pickerView: UIPickerView!
  @IBOutlet weak var btHaetti: UIButton!

  override func viewDidLoad() {
    super.viewDidLoad()
    pickerView.delegate = self
    pickerView.dataSource = self
    btHaetti.layer.cornerRadius = 10
    btHaetti.clipsToBounds = true
    self.becomeFirstResponder()

    var savedDraws = getLottoDraws()
    if (!savedDraws.isEmpty) {
      savedDraws.sort(by: { $0.date < $1.date })
    }
    loadCSVs(from: savedDraws.last?.date ?? "01.01.1986".toDate())
  }

  override var canBecomeFirstResponder: Bool {
    get {
      return true
    }
  }

  func getUrlForYear(year: Int) -> String {
    if (year < 2018) {
      return "https://www.win2day.at/download/lo_\(year).csv"
    } else {
      return "https://www.win2day.at/media/NN_W2D_STAT_Lotto_\(year).csv"
    }
  }

  func getSeparatorForYear(year: Int) -> Character {
    if (year < 2018) {
      return "\r\n"
    } else {
      return "\n"
    }
  }

  func loadCSVs(from: Date) {
    // DispatchQueue
    let startYear = from.getYear()
    for year in startYear...2019 {
      DispatchQueue.global(qos: .background).async { [weak self] () -> Void in
        guard self != nil else {
          return
        }
        let url = URL(string: self!.getUrlForYear(year: year))!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
          if error != nil {
            print("there's a problem")
          }
          print("year ------------------------------------------------------------- \(year) --------------------------------------------")
          let content = String(data: data!, encoding: String.Encoding.ascii)
          content?.split(separator: self!.getSeparatorForYear(year: year)).forEach { (line: Substring) in
            let lineAsString = String(line)
            let winNumbers = lineAsString.matches(for: "((([0-9]){1,2};){6})([Zz]){2}([.:])*;([0-9]){1,2};")
            if winNumbers.count > 0 {
              let dates = lineAsString.matches(for: "((([0-9]){1,2})\\.){2}")
              if dates.count > 0 {
                let date = "\(dates[0])\(year)".toDate()
                if (date > from) {
                  DispatchQueue.main.sync {
                    convertCsvAndSaveToDB(csv: winNumbers[0], date: date)
                  }
                }
              }
            }
            return
          }
        }
        task.resume()
      }
    }
  }

  func convertDateToString(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd.mm.yyyy"
    let newDate = dateFormatter.string(from: date)
    return newDate
  }

  func convertStringToDate(dateAsString: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd.mm.yyyy"
    dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
    guard let date = dateFormatter.date(from: dateAsString) else {
      fatalError()
    }
    return date
  }

  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 6
  }

  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return 45
  }

  override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
    if motion == .motionShake {

      for componentIndex in 0...5 {
        let randomNumber = Int(arc4random_uniform(UInt32(45))) + 1
        self.pickerView.selectRow(randomNumber, inComponent: componentIndex, animated: true)
      }
      print("shake it")
    }
  }

  @IBAction func haetti(_ sender: Any) {
    UIView.animate(withDuration: 0.1,
        animations: {
          self.btHaetti.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }, completion: { _ in
      UIView.animate(withDuration: 0.1,
          animations: {
            self.btHaetti.transform = CGAffineTransform.identity
          }, completion: { _ in
        UIView.animate(withDuration: 0.1,
            animations: {
              self.btHaetti.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            }, completion: { _ in
          UIView.animate(withDuration: 0.1,
              animations: {
                self.btHaetti.transform = CGAffineTransform.identity
              }, completion: { _ in
            self.calculateWinAndPerformSegue(sender)
          })
        })
      })
    })
  }

  func calculateWinAndPerformSegue(_ sender: Any) {
    let allDraws = getLottoDraws()
    var chosenNumbers: [Int16] = []
    for i in 0...5 {
      chosenNumbers.append(Int16(pickerView.selectedRow(inComponent: i) + 1))
    }
    chosenNumbers.sort()
    allDraws.forEach { draw in
      if (draw.numbers == chosenNumbers) {
        self.performSegue(withIdentifier: "winViewSegue", sender: sender)
      }
    }
    self.performSegue(withIdentifier: "loseViewSegue", sender: sender)
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "winViewSegue" {
      let winView = segue.destination as! WinViewController
      let number1 = pickerView.selectedRow(inComponent: 0) + 1
      let number2 = pickerView.selectedRow(inComponent: 1) + 1
      let number3 = pickerView.selectedRow(inComponent: 2) + 1
      let number4 = pickerView.selectedRow(inComponent: 3) + 1
      let number5 = pickerView.selectedRow(inComponent: 4) + 1
      let number6 = pickerView.selectedRow(inComponent: 5) + 1
      let winNumbers = "\(number1) \(number2) \(number3) \(number4) \(number5) \(number6)"
      winView.winNumbers = winNumbers
    }
  }

  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return String(row + 1)
  }

}

