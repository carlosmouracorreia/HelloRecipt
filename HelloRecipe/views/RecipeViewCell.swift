//
//  RecipeView.swift
//  HelloRecipe
//
//  Created by NTW-laptop on 12/02/18.
//  Copyright © 2018 Carlos Correia. All rights reserved.
//

import UIKit
import Kingfisher
import FloatRatingView

class RecipeViewCell : UITableViewCell {
    
    static let REUSE_ID = String(describing: RecipeViewCell.self)
    
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var heading: UILabel!
    @IBOutlet weak var calories: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var favoriteBtn: UIButton!
    @IBOutlet weak var floatRatingView: FloatRatingView!
    
    var recipe : Recipe?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        floatRatingView.delegate = self
        floatRatingView.contentMode = UIViewContentMode.scaleAspectFit
        floatRatingView.type = .halfRatings
        
        myImage.contentMode = .scaleAspectFill
        myImage.clipsToBounds = true 
    }
    
    
    public func setContent(_ recipe: Recipe) {
            self.recipe = recipe
            
            name.text = recipe.name
            heading.text = recipe.headline
            calories.text = recipe.calories ?? ""
        
            time.text = recipe.time ?? ""
        
        if let userRating = User.getUser()?.getRating(recipe: recipe) {
            floatRatingView.rating = userRating
        } else if recipe.rating > 0 {
            floatRatingView.rating = Double(recipe.rating)
        }
        
        if let imageURL = recipe.imageUrl {
            self.setImage(imageURL)
        }
            
        
        
        if let userData = User.getUser() {
            favoriteBtn.isSelected = userData.getFavorite(recipeId: recipe.id) != nil
        } else {
            favoriteBtn.isSelected = false
        }
    }
    
    public func setImage(_ image: UIImage?) {
        self.myImage.image = image
    }
    
    private func setImage(_ url: URL) {

        self.myImage.kf.setImage(with: url, options: [.transition(ImageTransition.fade(0.5))], completionHandler: { image, error, cacheType, imgURL in
            
            if let _ = error {
                self.setImage(UIImage(named: "misc_no_image")!)
            }
        })
    }
    
    
    @IBAction func favoritePressed(_ sender: UIButton) {
        
        if let recipe = self.recipe, let userData = User.getUser() {
            UIView.transition(with: self.favoriteBtn,
                              duration: 0.3,
                              options: .transitionCrossDissolve,
                              animations: {  self.favoriteBtn.isSelected = !self.favoriteBtn.isSelected },
                              completion: { _ in
                                
                                if self.favoriteBtn.isSelected {
                                    userData.addToFavorites(recipe: recipe)
                                } else {
                                    userData.removeFromFavorites(recipe: recipe)
                                }
                                
            })
        } else if User.getUser() == nil {
            //Send user to login page
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            if let tab = appDelegate.window!.rootViewController as? UITabBarController {
               tab.selectedIndex = 2
            }
        }
    }
}

extension RecipeViewCell : FloatRatingViewDelegate {
    func floatRatingView(_ ratingView: FloatRatingView, isUpdating rating: Double) {
        //liveLabel.text = String(format: "%.2f", self.floatRatingView.rating)
    }
    
    func floatRatingView(_ ratingView: FloatRatingView, didUpdate rating: Double) {
        if let recipe = self.recipe {
            if let user = User.getUser() {
                
                if rating == 0 {
                    user.setRatingOrNothing(recipe: recipe)
                } else {
                    user.setRatingOrNothing(recipe: recipe, rating: rating)
                }
                
            } else {
                
                self.floatRatingView.rating = Double(recipe.rating)
                
                //Send user to login page
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                
                if let tab = appDelegate.window!.rootViewController as? UITabBarController {
                    tab.selectedIndex = 2
                }
            }
        }
    }
}
