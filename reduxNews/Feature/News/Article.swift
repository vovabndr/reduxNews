//
//  New.swift
//  reduxNews
//
//  Created by Владимир Бондарь on 10/1/18.
//  Copyright © 2018 VladymyrBondar. All rights reserved.
//

import Foundation
extension News {
    struct Article: Equatable, Decodable {
      var title: String
      var description: String
      var url: String
      var urlToImage: String

      init(
      title: String,
      description: String,
      url: String,
      urlToImage: String) {
      self.title = title
      self.description = description
      self.url = url
      self.urlToImage = urlToImage
      }
  }
}
