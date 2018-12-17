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
    case .textFieldChange(let newText):
      return state.lense(by: \State.searchInput, value: newText)
        .lense(by: \State.page, value: 1)
        .lense(by: \State.article, value: [])
    case .loadNextArticles:
      return state.lense(by: \State.page, value: state.page+1)
    case .setArticles(let articles):
      return state.lense(by: \State.article, value: state.article+articles)
    case .showError(let error):
      return state.lense(by: \State.errorMessage, value: error)
    case .selectCell:
      return state
    }
  }
}
