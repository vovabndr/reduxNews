//
//  ReduxStore.swift
//  reduxNews
//
//  Created by Владимир Бондарь on 10/2/18.
//  Copyright © 2018 VladymyrBondar. All rights reserved.
//

import ReactiveSwift
import ReactiveCocoa

final class ReduxStore<State, Action> {
  typealias Reducer = (State, Action) -> State
  typealias Dispatch = (Action) -> Void
  typealias StateProvider = () -> State
  typealias Middleware = (@escaping Dispatch, @escaping () -> State) -> (@escaping Dispatch) -> Dispatch

  private let reducer: Reducer
  let state: Property<State>
  private var dispatchFunction: Dispatch!

  init(
    initialState: State,
    reducer: @escaping Reducer,
    middleWares: [Middleware]
    ) {

    let stateMutableProperety = MutableProperty(initialState)

    self.reducer = reducer
    self.state = Property(stateMutableProperety)
    let defaultDispatch = { action in
      stateMutableProperety.value = reducer(stateMutableProperety.value, action)
    }

    self.dispatchFunction = middleWares
      .reversed()
      .reduce(defaultDispatch, { (dispatchFunction, middleWare) -> Dispatch in
        let dispatch: Dispatch = { [weak self] in self?.dispatch(action: $0) }
        let getState: StateProvider = { stateMutableProperety.value }
        return middleWare(dispatch, getState)(dispatchFunction)
      })
  }

  func dispatch(action: Action) {
    dispatchFunction?(action)
  }

  static func makeMiddleware(worker: @escaping (@escaping Dispatch, StateProvider, Dispatch, Action) -> Void) -> Middleware {
    return { dispatch, getState in { next in { action in worker(dispatch, getState, next, action) } } }
  }

}
