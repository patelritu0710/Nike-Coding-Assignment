//
//  Extensions.swift
//  Nike-Coding-Challenge
//
//  Created by Ritu Patel on 10/20/19.
//  Copyright © 2019 Ritu Patel. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    class func showAlert(with message: String, on: UIViewController) {
        let alert = UIAlertController(title: "Some Error!!!", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        DispatchQueue.main.async {
            on.present(alert, animated: true)
        }
    }
}
