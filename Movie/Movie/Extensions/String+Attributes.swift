//
//  String+Attributes.swift
//  Movie
//
//  Created by Louise on 4/7/22.
//  Copyright © 2022 Louise Nicolas Namoc. All rights reserved.
//

import Foundation
import UIKit

extension String {
  func addTextAttribute(
    keyWords: [String],
    withTextColor color: UIColor,
    withFont font: UIFont
  ) -> NSAttributedString {
    let baseAttributed = NSMutableAttributedString(string: self)
    let range = NSRange(location: 0, length: utf16.count)
    for word in keyWords {
      guard let regex = try? NSRegularExpression(pattern: word, options: .caseInsensitive) else {
        continue
      }
      regex
        .matches(in: self, options: .withTransparentBounds, range: range)
        .forEach { baseAttributed
          .addAttributes(
            [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: font],
            range: $0.range
          )
        }
    }
    return baseAttributed
  }
}
