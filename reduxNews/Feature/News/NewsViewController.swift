//
//  ViewController.swift
//  reduxNews
//
//  Created by Владимир Бондарь on 10/1/18.
//  Copyright © 2018 VladymyrBondar. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Result
import ReactiveCocoa
import ReactiveSwift

extension News{
  final class ViewController: UIViewController {
    private lazy var newsView = NewsView.initFromNib()
    
    override func loadView() {
      view = newsView
    }
    
    let viewModel = ViewModel()
    
    override func viewDidLoad() {
      super.viewDidLoad()
      
      bindUI()
    }
    
    private func bindUI () {
      newsView.reactive.continuousTextValues
        .observe(on: UIScheduler())
        .take(duringLifetimeOf: self)
//        .producer
//        .map{$0! as String}
//        .startWithValues { (text) in
//          print(text)
//      }
////        .startWithValues {print($0)}
        .observeValues {print($0)}

      let inputs = ViewModel.Inputs(
          viewWillAppear: reactive.viewDidDisappear,
          searchText: newsView.reactive.searchText
        )
      
      let outputs = viewModel.makeOutputs(inputs:  inputs)
      
      outputs.props.producer
        .observe(on: UIScheduler())
        .take(duringLifetimeOf: self)
        .startWithValues { [weak self] (props) in
          self?.renderProps(props)
        }
    }
    
    private func renderProps(_ props: NewsView.Props) {
        newsView.renderProps(props: props)

    }
  }
}
