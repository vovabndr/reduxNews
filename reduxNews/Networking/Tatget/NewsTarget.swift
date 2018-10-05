//
//  NewsTarget.swift
//  reduxNews
//
//  Created by Владимир Бондарь on 10/3/18.
//  Copyright © 2018 VladymyrBondar. All rights reserved.
//

import Foundation

struct NewsTarget: TargetType {

  struct Response: Decodable {
    let status: String
    let totalResults: Int
    let articles: [News.Article]
  }
  let path = "v2/top-headlines"
  var method: HTTPMethod {
    return .get
  }
  var query: [String: Any]?

  var contentType: ContentType? {
    return ContentType.json
  }
  func getBodyData() throws -> Data? {
    return nil
  }
}
