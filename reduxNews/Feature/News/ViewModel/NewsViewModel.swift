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
  final class ViewModel {
    struct Inputs {
      let viewWillAppear: Signal<Void, NoError>
      let searchText: Signal<String?, NoError>
    }
    
    struct Outputs {
      let props: Property<NewsView.Props>
    }
    
    init(){}
    
    func makeOutputs(inputs: Inputs) -> Outputs {
      
      let initialState = State(article: [], error: nil, isNewsLoading: false)
      let store = ReduxStore<State, Action>(initialState: initialState, reducer: reduce)
      
      let props = store.state.map(StateToProps)
      
      
      let actionCreator = ActionCreator(inputs: inputs)
      
      actionCreator.actions
        .take(duringLifetimeOf: self)
        .observeValues(store.dispatch)
      
      return Outputs(props: props)
    }
    
  }
}
