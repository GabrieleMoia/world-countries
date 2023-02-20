//
//  UIImageExtension.swift
//  CountryWorld
//
//  Created by Gabriele Moia on 19/02/23.
//

import Foundation
import UIKit

extension UIImageView {
    func setImageFromStringrURL(stringUrl: String?) {
        guard let stringUrl = stringUrl else { return }
        if let url = URL(string: stringUrl) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
          // Error handling...
          guard let imageData = data else { return }

          DispatchQueue.main.async {
              self.image = UIImage(data: imageData)
          }
        }.resume()
      }
    }
}
