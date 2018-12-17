//
//  ViewModel.swift
//  reduxNews
//
//  Created by Владимир Бондарь on 10/1/18.
//  Copyright © 2018 VladymyrBondar. All rights reserved.
//

import Foundation

import Result
import ReactiveCocoa
import ReactiveSwift

extension News {
  enum Route {
    case detail(News.Article)
  }
  final class ViewModel {
    struct Inputs {
      let viewWillAppear: Signal<Void, NoError>
      let searchText: Signal<String?, NoError>
      let selectedRow: Signal<Int, NoError>
      let willDisplay: Signal<Void, NoError>
    }
    struct Outputs {
      let props: Property<NewsView.Props>
      let route: Signal<Route, NoError>
    }
    let newsService: NewsService
    init(newsService: NewsService) {
      self.newsService = newsService
    }

    func makeOutputs(inputs: Inputs) -> Outputs {
      let initialState = State(article: [], errorMessage: nil, page: 1, searchInput: "")
      let (route, routingMiddleware) = News.makeRoutingMiddleware()
      let paginationMiddleware = News.makePaginationMiddleware(newsService: newsService)

      let store = Store(
        initialState: initialState,
        reducer: reduce,
        middleWares: [routingMiddleware, paginationMiddleware]
      )

      let props = store.state.map(stateToProps)
      let actionCreator = ActionCreator(inputs: inputs)

      actionCreator.actions
        .take(duringLifetimeOf: self)
        .observeValues(store.dispatch)

      return Outputs(
        props: props,
        route: route
      )
    }
  }
}
