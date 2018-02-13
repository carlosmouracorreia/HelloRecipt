//
//  Recipe.swift
//  HelloRecipe
//
//  Created by NTW-laptop on 12/02/18.
//  Copyright © 2018 Carlos Correia. All rights reserved.
//

import ObjectMapper

enum RecipeSort {
    case rating
}

class Recipe : Mappable, Equatable {
    private static var inMemoryRecipes : Dictionary<String, Recipe>?

    
    public var id : String!
    public var name : String!
    public var headline : String!
    private var description : String? //TODO - Description Detail Screen - Popup
    public var rating : Float = 0
    public var time : String?
    public var calories : String?
    public var imageUrl : URL?
    
    
    required init?(map: Map){
        
        guard let _: String = map["id"].value(), let _: String = map["name"].value(), let _: String = map["headline"].value() else {
            return nil
        }
        
    }
    
    private func formatTimeString(unformattedTime: String)  -> String? {
        
        var mutableTime = unformattedTime
        
        //not the most elegant solution but this is what I expect from the "API"
        let timeMeasure = mutableTime.contains("M") ? "Minutes" : "Hours"
        
        mutableTime = mutableTime.trimmingCharacters(in: .uppercaseLetters)
        mutableTime = mutableTime.trimmingCharacters(in: .lowercaseLetters)
        
        if mutableTime.count > 0 {
            return "\(mutableTime) \(timeMeasure)"
        } else {
            return nil
        }
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        headline <- map["headline"]
        description <- map["description"]
        id <- map["id"]
        rating <- map["rating"]
        time <- map["time"]
        
        if let time = time {
            self.time = formatTimeString(unformattedTime: time)
        }
        
        calories <- map["calories"]

        var photoUrlString : String?
        photoUrlString <- map["image"]
        
        if let urlString = photoUrlString, let url = URL(string: urlString) {
            self.imageUrl = url
        }
    }
    
    public static func loadRecipes() {
        if inMemoryRecipes != nil {
            return
        }
        
        if let jsonString = FileUtils.loadDataString(name: "recipes", ofType: "json") {
            
            if let arr: Array<Recipe> = Mapper<Recipe>().mapArray(JSONString: jsonString) {
                if arr.count > 0 {
                    var recipes = Dictionary<String, Recipe>()
                    for recipe in arr {
                        recipes[recipe.id] = recipe
                    }
                    self.inMemoryRecipes = recipes
                }
                
            }
        }
        
       
    }
    
    //For testing purposes
    public static func removeRecipes() {
        self.inMemoryRecipes = nil
    }
    
    static func ==(lhs:Recipe, rhs:Recipe) -> Bool {
       return lhs.id == rhs.id
    }
    
    static func getMultiple(sortBy: RecipeSort, source: Dictionary<String, Recipe>? = nil) -> [Recipe]? {
        if let source = source {
            return source.values.sorted(by: { $0.getRating() > $1.getRating() })
        } else if let recipes = inMemoryRecipes {
            return recipes.values.sorted(by: { $0.getRating() > $1.getRating() })
        }
        return nil
    }
    
    //For testing purposes
    static func getOne(recipeId: String) -> Recipe? {
        if let recipes = inMemoryRecipes {
            return recipes[recipeId]
        }
        return nil
    }
    
    func getRating() -> Double {
        if let userRating = User.getUser()?.getRating(recipe: self) {
            return userRating
        }
        return Double(self.rating)
    }
}
