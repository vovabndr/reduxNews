//
//  NewsView.swift
//  reduxNews
//
//  Created by Владимир Бондарь on 10/1/18.
//  Copyright © 2018 VladymyrBondar. All rights reserved.
//

import UIKit
import ReactiveSwift
import Result

class NewsView: UIView, NibInitializable {
  struct Props {
    var news: [News.Article]
    var errorMessage: String?
  }

  @IBOutlet private weak var table: UITableView!
  @IBOutlet fileprivate weak var textField: UITextField!

  lazy var didSelectRowAt = Signal<Int, NoError>.pipe()
  lazy var willDisplay = Signal<Void, NoError>.pipe()
  private var news: [News.Article] = []
  private var renderedProps: Props?

  override func awakeFromNib() {
    super.awakeFromNib()
    setup()
  }

  private func setup() {
    table.delegate = self
    table.dataSource = self
    table.register(NewsTableViewCell.self)
  }

  func renderProps(props: Props) {
    if props.news != renderedProps?.news {
      self.news = props.news
      table.reloadData()
    }
    renderedProps = props
  }
}

extension NewsView: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    didSelectRowAt.input.send(value: indexPath.row)
  }
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if indexPath.row == news.count-1 {
      willDisplay.input.send(value: ())
    }
  }
}

extension NewsView: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return news.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = table.dequeueReusableCell(for: indexPath, cellType: NewsTableViewCell.self)
    cell.setNews(news[indexPath.row])
    return cell
  }
}

extension Reactive where Base: NewsView {
  var continuousTextValues: Signal<String?, NoError> {
    return base.textField.reactive.continuousTextValues
  }
}
