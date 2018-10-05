//
//  ViewController.swift
//  reduxNews
//
//  Created by Владимир Бондарь on 10/4/18.
//  Copyright © 2018 VladymyrBondar. All rights reserved.
//

import UIKit
import SafariServices

extension Detail {
  class ViewController: UIViewController {

    private lazy var detailView = DetailView.initFromNib()

    override func loadView() {
      view = detailView
    }

    let viewModel: ViewModel

    init(viewModel: ViewModel) {
      self.viewModel = viewModel
      super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }

      override func viewDidLoad() {
          super.viewDidLoad()
        detailView.render(article: viewModel.article )
        detailView.buttonPressed.observeValues { [weak self] (optStr) in
          guard let str = optStr, let url = URL(string: str) else { return }
          let safariViewController = SFSafariViewController(url: url)
          self?.present(safariViewController, animated: true)
        }
      }
  }
}
