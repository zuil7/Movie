//
//  TiggerableProtocols.swift
//  Movie
//
//  Created by Louise on 4/7/22.
//  Copyright © 2022 Louise Nicolas Namoc. All rights reserved.
//

import Foundation

protocol TriggerableProtocol: AnyObject {}

extension TriggerableProtocol {
  func trigger(_ callback: @escaping (Self) -> VoidResult) -> VoidResult {
    return { [weak self] in
      guard let self = self else { return }
      return callback(self)()
    }
  }

  func trigger<T>(_ callback: @escaping (Self) -> SingleResult<T>) -> SingleResult<T> {
    return { [weak self] result in
      guard let self = self else { return }
      return callback(self)(result)
    }
  }
}

extension NSObject: TriggerableProtocol {}
