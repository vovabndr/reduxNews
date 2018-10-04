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
    var news: [ArticleProps]
    var isLoading: Bool
    struct ArticleProps: Equatable {
      let title: String
      let url: URL?
    }
    init(state: News.State) {
      self.news = state.article.map { ArticleProps(title: $0.title, url: URL(string: $0.url))}
      self.isLoading = state.isNewsLoading
    }
  }

  @IBOutlet private weak var table: UITableView!
  @IBOutlet fileprivate weak var textField: UITextField!
  @IBOutlet weak var indicator: UIActivityIndicatorView!

  lazy var didSelectRowAt = Signal<Int, NoError>.pipe()
  private var news: [Props.ArticleProps] = []
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
    if props.isLoading != renderedProps?.isLoading {
      props.isLoading ? indicator.startAnimating() : indicator.stopAnimating()
    }

    renderedProps = props
  }
}

extension NewsView: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    didSelectRowAt.input.send(value: indexPath.row)
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
