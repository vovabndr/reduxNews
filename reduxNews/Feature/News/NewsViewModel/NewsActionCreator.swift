//
//  ActionCreator.swift
//  reduxNews
//
//  Created by Владимир Бондарь on 10/2/18.
//  Copyright © 2018 VladymyrBondar. All rights reserved.
//

import Result
import ReactiveSwift

extension News {
  final class ActionCreator {
    let actions: Signal<Action, NoError>
    init(inputs: ViewModel.Inputs) {
      let setLoadAction = inputs.searchText
            .skipNil().map(Action.textFieldChange)
      let setPaginationAction = inputs.willDisplay
        .map { _ in Action.loadNextArticles }
      let selectedAction = inputs.selectedRow.map(Action.selectCell)

      self.actions = Signal.merge(
        setLoadAction,
        selectedAction,
        setPaginationAction
      )
    }
  }
}
