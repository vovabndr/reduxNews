//
//  NewsMiddleware.swift
//  reduxNews
//
//  Created by Владимир Бондарь on 10/4/18.
//  Copyright © 2018 VladymyrBondar. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result

extension News {
  static func makeRoutingMiddleware() -> (Signal<Route, NoError>, Store.Middleware) {
    let routeSignal = Signal<Route, NoError>.pipe()
      let middleware = Store.makeMiddleware { _, getState, next, action in
        next(action)
        let state = getState()
        switch action {
        case .selectCell(let index):
          routeSignal.input.send(value: Route.detail(state.article[index]))

        default: break
        }
    }
    return (routeSignal.output, middleware)
  }
}
