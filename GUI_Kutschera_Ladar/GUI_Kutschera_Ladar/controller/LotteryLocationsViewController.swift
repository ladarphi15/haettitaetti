//
//  LotteryLocationsViewController.swift
//  GUI_Kutschera_Ladar
//
//  Created by Stefan Kutschera and Philipp Ladar on 07.11.18.
//  Copyright © 2018 hattitatti. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class SecondViewController: UIViewController, CLLocationManagerDelegate {

  @IBOutlet weak var map: MKMapView!
  let locationManager = CLLocationManager()
  var latitude: String?
  var longitude: String?

  override func viewDidLoad() {
    super.viewDidLoad()
    getUserLocation()
  }

  func getUserLocation() {
    self.locationManager.requestWhenInUseAuthorization()

    if CLLocationManager.locationServicesEnabled() {
      locationManager.delegate = self
      locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
      locationManager.startUpdatingLocation()
    }


  }

  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else {
      return
    }
    print("locations = \(locValue.latitude) \(locValue.longitude)")
    self.latitude = "\(locValue.latitude)"
    self.longitude = "\(locValue.longitude)"
    self.locationManager.stopUpdatingLocation()
    getLotteries()
  }

  func addAnnotations(coords: [CLLocation]) {
    map.removeAnnotations(map.annotations)
    for coord in coords {
      let CLLCoordType = CLLocationCoordinate2D(latitude: coord.coordinate.latitude,
          longitude: coord.coordinate.longitude);
      let anno = MKPointAnnotation();
      anno.coordinate = CLLCoordType;
      map.addAnnotation(anno);
    }

  }

  func getLotteries() {
    DispatchQueue.global(qos: .background).async { [weak self] () -> Void in
      guard self != nil else {
        return
      }
      let url = URL(string: "https://www.lotterien.at/api/geo/fetch?lat=\(self?.latitude ?? "47.070714")&lng=\(self?.longitude ?? "15.439503999999943")&count=20")!
      let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        if error != nil {
          print("there's a problem")
        }
        print("Lotteries:")
        do {
          let content = String(data: data!, encoding: String.Encoding.ascii)
          let lotteryLocation = try JSONDecoder().decode([LotteryLocation].self, from: content!.data(using: .utf8)!)
          let locations = lotteryLocation.map { location in
            CLLocation(latitude: location.position.latitude, longitude: location.position.longitude)
          }
          self?.addAnnotations(coords: locations)
          print("Lottery locations: \n \(lotteryLocation)")
        } catch let parseError as NSError {
          print("JSON Error \(parseError.localizedDescription)")
        }
      }
      task.resume()
    }
  }

}

