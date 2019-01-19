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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.winNumberLabel.text = winNumbers
    loadDraws()
    AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
  }
  
  func loadDraws() {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "LottoDrawEntity")
    request.returnsObjectsAsFaults = false
    do {
      let result = try context.fetch(request)
      for data in result as! [NSManagedObject] {		
		for i in 1...6 {
			print(String(data.value(forKey: "number\(i)") as! Int16))
		}
      }
      
    } catch {
      
      print("Failed")
    }
  }
  
  @IBAction func shareWinNumbers(_ sender: Any) {
    let shareText = """
                    Ich hätte am \(Date.init()) gewonen, tätti \(winNumbers) gespielt haben.
                    Spiel doch auch: haettitaetti://\(winNumbers.replacingOccurrences(of: " ", with: "", options: .literal, range: nil))
                    """
    let activityViewController = UIActivityViewController(activityItems: [shareText as NSString], applicationActivities: nil)
    
    present(activityViewController, animated: true, completion: {})
  }
  
  @IBAction func goBack(_ sender: Any) {
    self.dismiss(animated: true)
  }
}
