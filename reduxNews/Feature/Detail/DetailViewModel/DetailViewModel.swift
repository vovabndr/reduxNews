//
//  DetailViewModel.swift
//  reduxNews
//
//  Created by Владимир Бондарь on 10/4/18.
//  Copyright © 2018 VladymyrBondar. All rights reserved.
//

import Foundation

extension Detail {
  final class ViewModel {
    var article: Article

    init (article: Article) {
      self.article = article
    }
  }
}
