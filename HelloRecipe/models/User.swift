//
//  User.swift
//  HelloRecipe
//
//  Created by NTW-laptop on 12/02/18.
//  Copyright © 2018 Carlos Correia. All rights reserved.
//

import Foundation

@objc protocol NotificationDelegate {
    @objc optional func favoritesChanged()
    @objc optional func ratingsChanged()
}


class User {
    private static var userData : User?
    static var favoritesDelegate : NotificationDelegate?
    static var exploreDelegate : NotificationDelegate?


    /**
    * Notify Appropriate controllers of changes
    **/
    private var favorites = Dictionary<String, Recipe>() {
        didSet {
            //When favorite dictionary changes, we call the appropriate delegates
            User.callFavoriteDelegates()
        }
    }
    
    // Decided to just use the recipe identifier here
    private var ratings = Dictionary<String, Double>() {
        didSet {
            //When ratings dictionary changes, we call the appropriate delegates
            User.callRatingDelegates()
        }
    }
    
    
    
    init() {
        
    }
    
    private static func callFavoriteDelegates() {
        if let del = favoritesDelegate {
            del.favoritesChanged?()
        }
        
        if let del = exploreDelegate {
            del.favoritesChanged?()
        }
        
    }
    
    private static func callRatingDelegates() {
        if let del = favoritesDelegate {
            del.ratingsChanged?()
        }
        
        if let del = exploreDelegate {
            del.ratingsChanged?()
        }
        
    }
    
    public static func getUser() -> User? {
        return userData
    }
    
    public static func login() {
        if userData != nil {
            return
        }
        
        userData = User()
        
    }
    
    public static func logout() {
        userData?.favorites.removeAll()
        userData?.ratings.removeAll()
        User.callFavoriteDelegates()
        User.callRatingDelegates()
        userData = nil
    }
    
    
    public func getFavorites(sortBy: RecipeSort) -> [Recipe]? {
        return Recipe.getMultiple(sortBy: sortBy, source: favorites)
    }
    
    public func addToFavorites(recipe: Recipe) {
        //No problem to overwrite, never gets here
        favorites[recipe.id] = recipe
    }
    
    public func removeFromFavorites(recipe: Recipe) {
        favorites[recipe.id] = nil
    }
    
    public func getFavorite(recipeId: String) -> Recipe? {
        return favorites[recipeId]
    }
    
    
    public func setRatingOrNothing(recipe: Recipe, rating: Double? = nil) {
        ratings[recipe.id] = rating
    }
    
    public func getRating(recipe: Recipe) -> Double? {
        return ratings[recipe.id]
    }

}
