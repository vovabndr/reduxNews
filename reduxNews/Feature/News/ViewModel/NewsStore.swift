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
  
  struct State {
    var article:  [Article]
    var error: String?
    var isNewsLoading: Bool
  }
  
  enum Action {
    case setNews
    case setNewsSuccess([Article])
    case setError()
  }
}
