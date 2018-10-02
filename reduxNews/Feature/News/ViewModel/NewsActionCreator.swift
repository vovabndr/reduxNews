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
    
    static var moc: [Article] = [
      Article(title:"first", url: ""),
      Article(title:"second", url: ""),
      Article(title:"third", url: ""),
      Article(title:"foutyh", url: "")
    ]
    
    init(inputs: ViewModel.Inputs) {
      let setNewsAction = inputs.viewWillAppear.take(first: 1)
        .map { _ -> [Article] in News.ActionCreator.moc }
        .map(Action.setNewsSuccess)
      
      let setNewsAction2 = inputs.searchText
        .map { _ -> [Article] in News.ActionCreator.moc }
        .map( Action.setNewsSuccess)
      
      let actions = Signal<Action, NoError>.merge(setNewsAction, setNewsAction2)
      
      self.actions = actions
    }
    
  }
}
