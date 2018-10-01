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
extension News{
  final class ViewController: UIViewController {
    private lazy var newsView = NewsView.initFromNib()
    
    override func loadView() {
      view = newsView
    }
    override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view, typically from a nib.

    }


  }
}
