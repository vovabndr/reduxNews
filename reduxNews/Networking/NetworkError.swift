//
//  NetworkError.swift
//  reduxNews
//
//  Created by Владимир Бондарь on 10/3/18.
//  Copyright © 2018 VladymyrBondar. All rights reserved.
//

import Foundation
import Result

enum NetworkError: Error {
  case serializationError(message: String)
  case apiError(code: Int, message: String)
  case unknown(message: String)
}

extension NetworkError: CustomStringConvertible {
  var description: String {
    switch self {
    case let .serializationError(message):
      return "Serialization: \(message)"
    case let .apiError(_, message):
      return "\(message)"
    case let .unknown(message):
      return "Unknown: \(message)"
    }
  }
}
