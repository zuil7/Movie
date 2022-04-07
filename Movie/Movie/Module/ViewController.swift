//
//  ViewController.swift
//  Movie
//
//  Created by Louise Nicolas Namoc.
//  Copyright © 2020 "Organization Name". All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
}

extension ViewController {
  func showHud(message: String = "", color: UIColor = .white) {
    ProgressHud.shared.show(message: message, color: color)
  }

  func dismissHud() {
    ProgressHud.shared.dismiss()
  }

  func showAlert(title: String, message: String) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let ok = UIAlertAction(title: "Ok", style: .default) { _ in }
    alertController.addAction(ok)
    present(alertController, animated: true, completion: nil)
  }
}
