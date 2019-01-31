//
//  WinViewController.swift
//  GUI_Kutschera_Ladar
//
//  Created by Stefan Kutschera and Philipp Ladar on 07.11.18.
//  Copyright © 2018 hattitatti. All rights reserved.
//

import UIKit
import CoreData
import AudioToolbox

class WinViewController: UIViewController {

  @IBOutlet weak var winNumberLabel: UILabel!
  public var winNumbers = ""
  public var draw: LottoDraw? = nil
  public var numberOfMatches: Int = 0
  @IBOutlet weak var otherInfo: UILabel!

  override func viewDidLoad() {
    super.viewDidLoad()
    self.winNumberLabel.text = winNumbers
    if (numberOfMatches == 6) {
      otherInfo.text = "Du HÄTTEST den Jackpot gewonnen, TÄTTEST du am \(draw?.date.toString() ?? "ERROR") gespielt haben."
    } else if (numberOfMatches == 5) {
      otherInfo.text = "Du HÄTTEST 5 von 6 Zahlen richtig gehabt, TÄTTEST du am \(draw?.date.toString() ?? "ERROR") gespielt haben."
    } else if (numberOfMatches == 4) {
      otherInfo.text = "Du HÄTTEST 4 von 6 Zahlen richtig gehabt, TÄTTEST du am \(draw?.date.toString() ?? "ERROR") gespielt haben."
    }
    AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
  }

  @IBAction func shareWinNumbers(_ sender: Any) {
    let shareText = """
                    Ich hätte am gewonen, tätti \(winNumbers) gespielt haben.
                    Spiel doch auch: haettitaetti://\(winNumbers.replacingOccurrences(of: " ", with: "#", options: .literal, range: nil))
                    """
    let activityViewController = UIActivityViewController(activityItems: [shareText as NSString], applicationActivities: nil)

    present(activityViewController, animated: true, completion: {})
  }

  @IBAction func goBack(_ sender: Any) {
    self.dismiss(animated: true)
  }
}
