//
//  Lensable.swift
//  reduxNews
//
//  Created by Владимир Бондарь on 10/3/18.
//  Copyright © 2018 VladymyrBondar. All rights reserved.
//

import Foundation

protocol Lensable { }

extension Lensable {
  func lense<V>(by keyPath: WritableKeyPath<Self, V>, value: V) -> Self {
    var copy = self
    copy[keyPath: keyPath] = value
    return copy
  }
}
