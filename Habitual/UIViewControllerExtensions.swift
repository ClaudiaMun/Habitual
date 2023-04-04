//
//  UIViewControllerExtensions.swift
//  Habitual
//
//  Created by Claudia Munoz on 3/15/23.
//

import UIKit

extension UIViewController {
  static func instantiate() -> Self {
    return self.init(nibName: String(describing: self), bundle: nil)
  }
}
