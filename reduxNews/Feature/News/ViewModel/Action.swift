//
//  Action.swift
//  reduxNews
//
//  Created by Владимир Бондарь on 10/1/18.
//  Copyright © 2018 VladymyrBondar. All rights reserved.
//

import Foundation

extension News {
  enum Action {
      case findNews([News])
      case deatail(Int)
  }
}
