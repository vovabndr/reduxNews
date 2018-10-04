//
//  ViewController.swift
//  reduxNews
//
//  Created by Владимир Бондарь on 10/1/18.
//  Copyright © 2018 VladymyrBondar. All rights reserved.
//

import UIKit
import Result
import ReactiveCocoa
import ReactiveSwift

extension News {
  final class ViewController: UIViewController {

    let viewModel: ViewModel
    init(viewModel: ViewModel) {
      self.viewModel = viewModel
      super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }

    private lazy var newsView = NewsView.initFromNib()

    override func loadView() {
      view = newsView
    }

    override func viewDidLoad() {
      super.viewDidLoad()
      bindUI()
    }

    private func bindUI () {
      let inputs = ViewModel.Inputs(
          viewWillAppear: reactive.viewWillAppear,
          searchText: newsView.reactive.continuousTextValues,
          selectedRow: newsView.didSelectRowAt.output
        )

      let outputs = viewModel.makeOutputs(inputs: inputs)

      outputs.props.producer
        .observeForUI()
        .take(duringLifetimeOf: self)
        .startWithValues { [weak self] props in
          self?.renderProps(props)
        }

      outputs.route.producer
        .observeForUI()
        .startWithValues { [weak self] route in self?.navigate(by: route) }
    }

    private func renderProps(_ props: NewsView.Props) {
        newsView.renderProps(props: props)
    }

    private func navigate(by route: Route) {
      switch route {
      case .detail(let article):
        print(article.title)
      }
    }
  }
}
