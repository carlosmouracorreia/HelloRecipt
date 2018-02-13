//
//  HelloTabBarController.swift
//  HelloRecipe
//
//  Created by NTW-laptop on 13/02/18.
//  Copyright © 2018 Carlos Correia. All rights reserved.
//

import UIKit

class HelloTabBarController : UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        //In order to update the current ratings in case of changing within the used controller, then moving to other controller, and getting back to the previous -> Getting then an ordered list again
        
        if tabBarController.selectedIndex == 0 {
            User.favoritesDelegate?.ratingsChanged?()
        }
        
        if tabBarController.selectedIndex == 1 {
            User.exploreDelegate?.ratingsChanged?()
        }
    }
}
