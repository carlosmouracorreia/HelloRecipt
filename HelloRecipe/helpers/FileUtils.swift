//
//  FileUtils.swift
//  HelloRecipe
//
//  Created by NTW-laptop on 12/02/18.
//  Copyright © 2018 Carlos Correia. All rights reserved.
//

import UIKit

class FileUtils {
    public static func loadDataString(name : String, ofType: String) -> String? {
        if let filepath = Bundle.main.path(forResource: name, ofType: ofType) {
            do {
                let contents = try String(contentsOfFile: filepath)
                return contents
            } catch {
               
            }
        }
        
        print("Error loading file with name \(name).\(ofType) from Main Bundle")
        return nil
        
    }
}
