//
//  DetailView.swift
//  reduxNews
//
//  Created by Владимир Бондарь on 10/4/18.
//  Copyright © 2018 VladymyrBondar. All rights reserved.
//

import UIKit
import Result
import ReactiveSwift

class DetailView: UIView, NibInitializable {

  @IBOutlet weak var image: UIImageView!
  @IBOutlet weak var authorLabel: UILabel!
  @IBOutlet weak var webButton: UIButton!
  @IBOutlet weak var contentTextView: UITextView!
  lazy var buttonPressed = webButton.reactive
    .controlEvents(.touchUpInside)
    .map { _ in self.article?.url }
  var article: Detail.Article?

  func render(article: Detail.Article ) {
    self.article = article
    contentTextView.text = article.description
    image.dowmload(from: article.urlToImage)
  }
}
