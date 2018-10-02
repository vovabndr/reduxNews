//
//  Props.swift
//  reduxNews
//
//  Created by Владимир Бондарь on 10/2/18.
//  Copyright © 2018 VladymyrBondar. All rights reserved.
//

import Foundation

extension News {
  typealias Props = NewsView.Props
  
  static func StateToProps(_ state: State) -> Props {
    return Props(news: state.article.map {
      Props.ArticleProps(title: $0.title, url: URL(string: $0.url))
    })
  }
}
