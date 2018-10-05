//
//  NewsTableViewCell.swift
//  reduxNews
//
//  Created by Владимир Бондарь on 10/2/18.
//  Copyright © 2018 VladymyrBondar. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell, ReusableCell, NibInitializable {

  @IBOutlet weak var label: UILabel!
  @IBOutlet weak var urlLabel: UILabel!

  func setNews(_ news: NewsView.Props.ArticleProps) {
    self.label.text = news.title
    self.urlLabel.text = news.url?.absoluteString
  }
}
