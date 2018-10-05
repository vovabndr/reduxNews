//
//  ImageViewExtension.swift
//  reduxNews
//
//  Created by Владимир Бондарь on 10/4/18.
//  Copyright © 2018 VladymyrBondar. All rights reserved.
//

import UIKit

extension UIImageView {
  func dowmload(from str: String) {
    guard let url = URL(string: str) else { return }
      URLSession.shared.dataTask(with: url) { data, response, error in
        guard
          let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
          let data = data, error == nil,
          let image = UIImage(data: data)
          else { return }
        DispatchQueue.main.async {
            self.image = image
          }
        }.resume()
    }
}
