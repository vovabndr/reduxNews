//
//  NewsService.swift
//  reduxNews
//
//  Created by Владимир Бондарь on 10/3/18.
//  Copyright © 2018 VladymyrBondar. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result

protocol NewsServiceProtocol {
  func getNews(search text: String, page: Int ) -> SignalProducer<[News.Article], NetworkError>
}

final class NewsService: NewsServiceProtocol {
  private let networkClient: NetworkClientProtocol

  init(networkClient: NetworkClientProtocol) {
    self.networkClient = networkClient
  }

  func getNews(search text: String, page: Int ) -> SignalProducer<[News.Article], NetworkError> {
    let query: [String: Any] = ["page": "\(page)", "q": text, "apiKey": "0f6c253e10424cfba2b91e2c7e5d9b85"]
    let target = NewsTarget(query: query)
      return self.networkClient.request(target)
        .map {$0.articles}
  }

}
