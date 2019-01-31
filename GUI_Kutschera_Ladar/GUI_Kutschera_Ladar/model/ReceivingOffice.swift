//
//  ReceivingOffice.swift
//  GUI_Kutschera_Ladar
//
//  Created by Philipp Ladar on 28.01.19.
//  Copyright © 2019 hattitatti. All rights reserved.
//

import Foundation

public struct LotteryLocation: Decodable {
  let position: Location
  let address: Address
  let games: GameOption
  let open: OpeningTimes
}

public struct Location: Decodable {
  let latitude: Double
  let longitude: Double
  let distance: Double
}

public struct Address: Decodable {
  let branch: String
  let title: String
  let street: String
  let zip: Int
  let city: String
  let province: String
}

public struct GameOption: Decodable {
  let instant: Bool
  let lottery: Bool
  let betting: Bool
  let quick: Bool
}

public struct OpeningTimes: Decodable {
  let mon: QuantumValue
  let tue: QuantumValue
  let wed: QuantumValue
  let thu: QuantumValue
  let fri: QuantumValue
  let sat: QuantumValue
  let sun: QuantumValue
  let hol: QuantumValue
}

enum QuantumValue: Decodable {
  case bool(Bool), openingHours(OpeningHours)

  init(from decoder: Decoder) throws {
    if let string = try? decoder.singleValueContainer().decode(OpeningHours.self) {
      self = .openingHours(string)
      return
    }

    if let int = try? decoder.singleValueContainer().decode(Bool.self) {
      self = .bool(int)
      return
    }
    self = .bool(false)
    return
  }

  enum QuantumError: Error {
    case missingValue
  }
}

public struct OpeningHours: Decodable {
  let am: String
  let pm: Bool
  let openToday: Bool
  let openNow: Bool
}

