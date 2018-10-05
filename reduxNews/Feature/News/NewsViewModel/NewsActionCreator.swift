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

    init(inputs: ViewModel.Inputs, newsService: NewsService) {
      let error = Signal<String, NoError>.pipe()
      let isLoading = Signal<Bool, NoError>.pipe()

      let setLoadAction = inputs.searchText
        .skipNil()
        .flatMap(.latest) { search  in
          newsService.getNews(search: search, page: 1)
            .on(
              starting: { isLoading.input.send(value: true) },
              terminated: { isLoading.input.send(value: false) }
            )
            .flatMapError { _ in .empty }
        }
        .map(Action.setNewsSuccess)

      let setErrorAction = error.output
        .map(Action.setError)

      let setLoadingAction = isLoading.output
        .map(Action.loadStatus)

      let selectedAction = inputs.selectedRow.map(Action.select)

      self.actions = Signal.merge(
        setLoadAction,
        setErrorAction,
        setLoadingAction,
        selectedAction
      )
    }
  }
}
