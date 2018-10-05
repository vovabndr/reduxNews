//
//  NewsServiceError.swift
//  reduxNews
//
//  Created by Владимир Бондарь on 10/3/18.
//  Copyright © 2018 VladymyrBondar. All rights reserved.
//

import Foundation

enum NewsServiceError: Error, CustomStringConvertible {
  case error(String)

  var description: String {
    switch self {
    case .error(let message): return "\(message)"
    }
  }
}
