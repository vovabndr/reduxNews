//
//  UIview+.swift
//  reduxNews
//
//  Created by Владимир Бондарь on 10/1/18.
//  Copyright © 2018 VladymyrBondar. All rights reserved.
//

import UIKit

protocol NibInitializable {
  static var nibName: String { get }
  static var nib: UINib { get }
  static func initFromNib() -> Self
}

extension NibInitializable where Self: UIView {
  static var nibName: String {
    return String(describing: Self.self)
  }
  
  static var nib: UINib {
    return UINib(nibName: nibName, bundle: nil)
  }
  
  static func initFromNib() -> Self {
    guard let view = nib.instantiate(withOwner: nil, options: nil).first as? Self else {
      fatalError("Could not instantiate view from nib with name \(nibName).")
    }
    
    return view
  }
}
