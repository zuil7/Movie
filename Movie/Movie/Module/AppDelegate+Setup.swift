//
//  AppDelegate+Setup.swift
//  Movie
//
//  Created by Louise on 2/7/22.
//  Copyright © 2022 Louise Nicolas Namoc. All rights reserved.
//

import AlamofireNetworkActivityLogger
import Foundation
import IQKeyboardManagerSwift

extension AppDelegate {
  func setup() {
    IQKeyboardManager.shared.enable = true
    IQKeyboardManager.shared.shouldResignOnTouchOutside = true

    #if DEBUG
      NetworkActivityLogger.shared.level = .debug
      NetworkActivityLogger.shared.startLogging()
    #endif
  }
}
