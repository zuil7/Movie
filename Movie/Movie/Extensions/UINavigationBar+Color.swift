//
//  UINavigationBar+Color.swift
//  Movie
//
//  Created by Louise on 4/7/22.
//  Copyright © 2022 Louise Nicolas Namoc. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {
  func customizeNavBar(barColor: UIColor, textColor: UIColor, hideHairLine: Bool = false) {
    setNavigationBarHidden(false, animated: false)
    let backButton = UIBarButtonItem()
    backButton.title = " "
    navigationBar.topItem?.backBarButtonItem = backButton
    navigationBar.tintColor = textColor
      
    if hideHairLine {
      navigationBar.setBackgroundImage(UIImage(), for: .default)
      navigationBar.shadowImage = UIImage()
    }

    if #available(iOS 15, *) {
      let appearance = UINavigationBarAppearance()
      appearance.configureWithOpaqueBackground()
      appearance.backgroundColor = barColor
      appearance.titleTextAttributes = [
        .foregroundColor: textColor,
        .font: UIFont.systemFont(ofSize: 17, weight: .medium)
      ]

      appearance.shadowColor = .clear
      appearance.shadowImage = UIImage()

      navigationBar.standardAppearance = appearance
      navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
    }
  }
}
