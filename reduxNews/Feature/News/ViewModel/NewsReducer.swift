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
    switch action {
    case .loadStatus(let status):
      return state.lense(by: \State.isNewsLoading, value: status)
    case .setError:
      return state.lense(by: \State.error, value: "error")
    case .setNewsSuccess(let newArticles):
      return state.lense(by: \State.article, value: newArticles)
    }
  }
}
