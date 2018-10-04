//
//  ErrorResponse.swift
//  reduxNews
//
//  Created by Владимир Бондарь on 10/3/18.
//  Copyright © 2018 VladymyrBondar. All rights reserved.
//

import Foundation

struct ErrorResponse: Decodable {
  let message: String
  enum CodingKeys: String, CodingKey {
    case message = "msg"
  }
}
