//
//  New.swift
//  reduxNews
//
//  Created by Владимир Бондарь on 10/1/18.
//  Copyright © 2018 VladymyrBondar. All rights reserved.
//

import Foundation
extension News {
    struct Article: Equatable, Decodable {
      var title: String
      var url: String
  }
}
