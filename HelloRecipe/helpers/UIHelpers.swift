//
//  UIHelpers.swift
//  HelloRecipe
//
//  Created by NTW-laptop on 13/02/18.
//  Copyright © 2018 Carlos Correia. All rights reserved.
//

import UIKit

class UIHelpers {
    class func presentDialog(title: String,message: String,view: UIViewController, action: ((UIAlertAction) -> ())? = nil) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: action))
        view.present(ac, animated: true, completion: nil)
    }
}
