//
//  TargetType.swift
//  reduxNews
//
//  Created by Владимир Бондарь on 10/3/18.
//  Copyright © 2018 VladymyrBondar. All rights reserved.
//

import Foundation

protocol TargetType {
  associatedtype Response: Decodable
  var path: String { get }
  var query: [String: Any]? { get }
  var method: HTTPMethod { get }
  var contentType: ContentType? { get }
  func getBodyData() throws -> Data?
}
