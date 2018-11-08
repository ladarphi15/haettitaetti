//
//  FirstViewController.swift
//  GUI_Kutschera_Ladar
//
//  Created by Stefan Kutschera and Philipp Ladar on 07.11.18.
//  Copyright © 2018 hattitatti. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

  @IBOutlet weak var pickerView: UIPickerView!
  override func viewDidLoad() {
    super.viewDidLoad()
    pickerView.delegate = self
    pickerView.dataSource = self
    
    loadCSVs()
  }

  func loadCSVs() {
    // DispatchQueue
    let url = URL(string: "https://www.win2day.at/download/lo_1998.csv")!
    DispatchQueue.global(qos: .background).async { [weak self] () -> Void in
      guard self == self else { return }
      let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        if error != nil {
          print("there's a problem")
        }
        print("http request successful")
        print(String(data: data!, encoding: String.Encoding.ascii) ?? "")
      }
      task.resume()
    }
  }
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 6
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return 45
  }
  
  @IBAction func haetti(_ sender: Any) {
    let randomNumber = Int(arc4random_uniform(UInt32(2)))
    print(randomNumber)
    if (randomNumber == 1) {
      performSegue(withIdentifier: "winViewSegue", sender: sender)
    } else {
      performSegue(withIdentifier: "loseViewSegue", sender: sender)
    }
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
