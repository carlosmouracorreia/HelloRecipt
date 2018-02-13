//
//  LoggedInViewController.swift
//  HelloRecipe
//
//  Created by NTW-laptop on 12/02/18.
//  Copyright © 2018 Carlos Correia. All rights reserved.
//

import UIKit

class LoggedInViewController : UIViewController {
    var logoutClosure : (() ->())!

    @IBAction func logoutPressed(_ sender: UIButton) {
        User.logout()
        self.logoutClosure()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.view.updateConstraints()
        self.view.layoutIfNeeded()
    }
}
