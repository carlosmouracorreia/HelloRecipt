//
//  HelloRecipeTests.swift
//  HelloRecipeTests
//
//  Created by NTW-laptop on 12/02/18.
//  Copyright © 2018 Carlos Correia. All rights reserved.
//

import XCTest
@testable import HelloRecipe

class HelloRecipeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        Recipe.loadRecipes()
    }
    
    override func tearDown() {
        Recipe.removeRecipes()
        User.logout()
        super.tearDown()
    }
    
    func testLoginWorks() {
        User.login()
        
        XCTAssertNotNil(User.getUser())
    }
    
    func testGetFirstRecipe() {
        if let multiple = Recipe.getMultiple(sortBy: .rating) {
            for one in multiple {
                XCTAssertNotNil(Recipe.getOne(recipeId: one.id))
                break
            }
        } else {
            XCTAssertNil(nil)
        }
        
    }
    
    func testAddFavoriteRecipe() {
        
        User.login()
        let user = User.getUser()!
        let recipe = Recipe.getMultiple(sortBy: .rating)![0]
        user.addToFavorites(recipe: recipe)
        
        XCTAssertNotNil(user.getFavorite(recipeId: recipe.id))
        
    }
    
    
    func testAddRating() {
        User.login()
        let user = User.getUser()!
        
        let recipe = Recipe.getMultiple(sortBy: .rating)![0]
        user.setRatingOrNothing(recipe: recipe, rating: 5)
        
        XCTAssertNotNil(user.getRating(recipe: recipe))
    }
    
    func testAddRatingThenGetReciptRatingIsFromUser() {
        User.login()
        let user = User.getUser()!
        
        let recipe = Recipe.getMultiple(sortBy: .rating)![0]
        recipe.rating = 1
        
        user.setRatingOrNothing(recipe: recipe, rating: 5)
        
        XCTAssert(recipe.getRating() == user.getRating(recipe: recipe))
    }
    
    func testAddFavoriteAndRatingEqualsNonFavoriteRating() {
        User.login()
        let user = User.getUser()!
        let recipe = Recipe.getMultiple(sortBy: .rating)![0]
        recipe.rating = 1
        user.addToFavorites(recipe: recipe)
        
        user.setRatingOrNothing(recipe: recipe, rating: 5)

        let favorite = user.getFavorite(recipeId: recipe.id)
        XCTAssertNotNil(favorite)
        XCTAssert(favorite?.getRating() == recipe.getRating())
    }
    
    
    // MARK : Logout tests
    
    func testUserNilAfterLogout() {
        User.login()
        User.logout()
        XCTAssertNil(User.getUser())
        
    }
    
    func testInteractAndRatingGetsDefaultAfterLogout() {
        User.login()
        let user = User.getUser()!
        
        let recipe = Recipe.getMultiple(sortBy: .rating)![0]
        recipe.rating = 1
        let userRating : Double = 5
        user.setRatingOrNothing(recipe: recipe, rating: userRating)
        XCTAssert(recipe.getRating() == user.getRating(recipe: recipe))

        User.logout()
        
        XCTAssert(recipe.getRating() != userRating)
    }
    
    //TODO - Tests with sorting!
}
