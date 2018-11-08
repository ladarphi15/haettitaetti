//
//  WinViewController.swift
//  GUI_Kutschera_Ladar
//
//  Created by Stefan Kutschera and Philipp Ladar on 07.11.18.
//  Copyright © 2018 hattitatti. All rights reserved.
//

import UIKit

class WinViewController: UIViewController {
  
  @IBOutlet weak var winNumberLabel: UILabel!
  public var winNumbers = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.winNumberLabel.text = winNumbers
  }
  
  @IBAction func goBack(_ sender: Any) {
    self.dismiss(animated: true)
  }
}