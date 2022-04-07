//
//  UIImageView+KingFisher.swift
//  Movie
//
//  Created by Louise on 4/7/22.
//  Copyright © 2022 Louise Nicolas Namoc. All rights reserved.
//

import Kingfisher

extension UIImageView {
  func setImageWithURL(
    _ url: URL?,
    placeholder: UIImage? = nil,
    onSuccess: @escaping SingleResult<UIImage> = DefaultClosure.singleResult(),
    onError: @escaping ErrorResult = DefaultClosure.singleResult()
  ) {
    guard let url = url else {
      image = nil
      return
    }
    kf.setImage(
      with: url,
      placeholder: placeholder,
      options: [.transition(.fade(1)), .loadDiskFileSynchronously]
    ) { result in
      switch result {
      case let .success(value):
        onSuccess(value.image)
      case let .failure(error):
        debugPrint(error.localizedDescription)
      }
    }
  }
}
