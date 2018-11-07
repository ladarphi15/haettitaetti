//
//  FirstViewController.swift
//  GUI_Kutschera_Ladar
//
//  Created by Philipp Ladar on 07.11.18.
//  Copyright © 2018 hattitatti. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

  @IBOutlet weak var pickerView: UIPickerView!
  override func viewDidLoad() {
    super.viewDidLoad()
    pickerView.delegate = self
    pickerView.dataSource = self
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
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return String(row + 1)
  }

}

