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
class NewsView: UIView, NibInitializable  {
  struct Props {
    var news: [ArticleProps]
    
    struct ArticleProps: Equatable {
      let title: String
      let url: URL?
    }
  }
  
  @IBOutlet private weak var table: UITableView!
  @IBOutlet fileprivate weak var textField: UITextField!
  
  private var news: [Props.ArticleProps] = []
  private var renderedProps: Props?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setup()
  
    table.delegate = self
    table.dataSource = self
    
    table.register(NewsTableViewCell.self)
  }
  
  private func setup() {
    
  }
  
  func renderProps(props: Props) {
    if props.news != renderedProps?.news  {
      self.news = props.news
      table.reloadData()
    }
    
    renderedProps = props
  }
}

extension NewsView: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return news.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = table.dequeueReusableCell(for: indexPath, cellType: NewsTableViewCell.self)
    cell.label.text = news[indexPath.row].title
    return cell
  }
}

extension NewsView: UITableViewDelegate {
  
}

extension Reactive where Base: NewsView {
  var searchText: Signal<String?, NoError> {
    return base.textField.reactive.textValues
  }
  
  
  var continuousTextValues: Signal<String?, NoError> {
    return base.textField.reactive.continuousTextValues
  }
  
}
