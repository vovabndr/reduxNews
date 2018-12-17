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
    var errorMessage: String?
    var page: Int
    var searchInput: String
  }

  enum Action {
    case showError(String)
    case textFieldChange(String)
    case loadNextArticles
    case setArticles([Article])
    case selectCell(Int)
  }
}
