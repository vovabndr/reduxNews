//
//  Store.swift
//  reduxNews
//
//  Created by Владимир Бондарь on 10/2/18.
//  Copyright © 2018 VladymyrBondar. All rights reserved.
//

import Foundation

extension News {
  typealias Store = ReduxStore<State, Action>

  struct State: Lensable {
    var article: [Article]
    var error: String?
    var isNewsLoading: Bool
  }

  enum Action {
    case loadStatus(Bool)
    case setNewsSuccess([Article])
    case setError(String)
    case select(Int)
  }
}
