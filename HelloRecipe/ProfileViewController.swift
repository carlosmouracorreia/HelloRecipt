//
//  FavoritesViewController.swift
//  ProfileViewController
//
//  Created by NTW-laptop on 12/02/18.
//  Copyright © 2018 Carlos Correia. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    static let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
    
    lazy var loginViewController : LoginViewController = {
        let controller = ProfileViewController.storyboard.instantiateViewController(withIdentifier: String(describing: LoginViewController.self)) as! LoginViewController
        controller.loginClosure = loginClicked
        controller.view.frame = self.view.bounds
        return controller
    }()
    
    lazy var loggedInViewController : LoggedInViewController = {
        let controller = ProfileViewController.storyboard.instantiateViewController(withIdentifier: String(describing: LoggedInViewController.self)) as! LoggedInViewController
        controller.logoutClosure = logoutClicked
        controller.view.frame = self.view.bounds
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.addChildViewController(loginViewController)
        self.view.addSubview(loginViewController.view)
        
        self.navigationItem.title = "Profile"

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
     
    }
    
}

extension ProfileViewController {
    func loginClicked() {
        loginViewController.view.removeFromSuperview()
        loginViewController.removeFromParentViewController()
        
        self.addChildViewController(loggedInViewController)
        self.view.addSubview(loggedInViewController.view)

    }
    
    func logoutClicked() {
        loggedInViewController.view.removeFromSuperview()
        loggedInViewController.removeFromParentViewController()

        self.addChildViewController(loginViewController)
        self.view.addSubview(loginViewController.view)
    }
}
