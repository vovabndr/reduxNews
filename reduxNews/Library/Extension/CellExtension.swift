//
//  Cell+.swift
//  reduxNews
//
//  Created by Владимир Бондарь on 10/2/18.
//  Copyright © 2018 VladymyrBondar. All rights reserved.
//

import UIKit

protocol ReusableCell {
  static var reuseIdentifier: String { get }
}

extension ReusableCell {
  static var reuseIdentifier: String {
    return String(describing: Self.self)
  }
}

extension UITableView {
  func dequeueReusableCell<Cell: ReusableCell>(withType type: Cell.Type, forRowAt indexPath: IndexPath) -> Cell {
    guard let cell = self.dequeueReusableCell(withIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell else {
      fatalError("Could not dequeue reusable cell with \(Cell.reuseIdentifier) reuse identifier.")
    }
    
    return cell
  }
  
  func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath, cellType: T.Type = T.self) -> T where T: ReusableCell {
    guard let cell = self.dequeueReusableCell(withIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
      fatalError("Failed to dequeue a cell with identifier \(cellType.reuseIdentifier) matching type \(cellType.self).")
    }
    
    return cell
  }
  
  func register<T: UITableViewCell>(_ cellType: T.Type) where T: ReusableCell {
    self.register(cellType.self, forCellReuseIdentifier: cellType.reuseIdentifier)
  }
  
  func register<T: UITableViewCell>(_ cellType: T.Type) where T: ReusableCell & NibInitializable {
    self.register(cellType.nib, forCellReuseIdentifier: cellType.reuseIdentifier)
  }
}
