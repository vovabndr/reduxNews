//
//  NewsReducer.swift
//  reduxNews
//
//  Created by Владимир Бондарь on 10/2/18.
//  Copyright © 2018 VladymyrBondar. All rights reserved.
//

import Foundation
extension News {
  static func reduce(state: State, action: Action) -> State {
    var state = state
    
    switch action {
    case .setNews:
      state.isNewsLoading = true
    case .setError:
      state.isNewsLoading = false
      state.error = "error"
    case .setNewsSuccess(let newArticles):
      state.article = newArticles
    }
    return state
  }
}
