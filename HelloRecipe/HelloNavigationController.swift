//
//  HelloNavigationController.swift
//  HelloRecipe
//
//  Created by NTW-laptop on 12/02/18.
//  Copyright © 2018 Carlos Correia. All rights reserved.
//

import UIKit

class HelloNavigationController : UINavigationController {
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationBar.barTintColor = UIColor().mainColor()
        
        navigationBar.tintColor = UIColor.white
        navigationBar.titleTextAttributes = [ NSAttributedStringKey.font: UIFont(name: "Menlo-Bold", size: 19)!, NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = false
    
    }
    
    
    func currrentTabItem() -> Int {
         let appDelegate = UIApplication.shared.delegate as! AppDelegate
         
         if let tab = appDelegate.window!.rootViewController as? UITabBarController {
            return tab.selectedIndex
         } else {
            fatalError("There should be a TabBarController")
        }
        
    }
}

