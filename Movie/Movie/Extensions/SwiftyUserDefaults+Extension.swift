//
//  SwiftyUserDefaults+Extension.swift
//  Movie
//
//  Created by Louise Nicolas Namoc on 8/12/21.
//  Copyright © 2021 Louise Nicolas Namoc. All rights reserved.
//

import SwiftyUserDefaults

extension DefaultsKeys {
  var token: DefaultsKey<String?> { .init("token", defaultValue: "") }
}
