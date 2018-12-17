//
//  ReactiveExtensions.swift
//  reduxNews
//
//  Created by Владимир Бондарь on 10/3/18.
//  Copyright © 2018 VladymyrBondar. All rights reserved.
//

import ReactiveSwift
import Result

extension SignalProducerProtocol {
  public func observeForUI() -> SignalProducer<Value, Error> {
    return self.producer.observe(on: UIScheduler())
  }
  func toVoid() -> SignalProducer<Void, Error> {
    return self.producer.map { _ in Void() }
  }
}
extension SignalProtocol {
  func toVoid() -> Signal<Void, Error> {
    return self.signal.map { _ in Void() }
  }
  func observeForUI() -> Signal<Value, Error> {
    return self.signal.observe(on: UIScheduler())
  }
}
