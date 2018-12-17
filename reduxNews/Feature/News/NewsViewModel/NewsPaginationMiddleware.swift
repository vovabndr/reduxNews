//
//  NewsPaginationMiddleware.swift
//  reduxNews
//
//  Created by Владимир Бондарь on 10/5/18.
//  Copyright © 2018 VladymyrBondar. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result

extension News {
  static func makePaginationMiddleware(newsService: NewsService) ->  Store.Middleware {
    return Store.makeMiddleware { dispatch, getState, next, action in
      next(action)
      let state = getState()
      switch action {
      case .textFieldChange, .loadNextArticles:
        newsService.getNews(search: state.searchInput, page: state.page)
          .on(failed: { _ in
            dispatch(Action.showError("Error occured"))
          })
          .flatMapError { _ in Signal<[News.Article], NoError>.empty }
          .startWithValues { articlesArr in
            dispatch(.setArticles(articlesArr))
          }
      default: break
      }
    }
  }
}
