//
//  RecipesViewController.swift
//  HelloRecipe
//
//  Created by NTW-laptop on 12/02/18.
//  Copyright © 2018 Carlos Correia. All rights reserved.
//

import UIKit

class RecipesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.separatorStyle = .none
            tableView.register(UINib(nibName: RecipeViewCell.REUSE_ID, bundle: Bundle.main), forCellReuseIdentifier: RecipeViewCell.REUSE_ID)
        }
    }
    var recipes : [Recipe]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "HelloRecipe"
        self.title = "Explore"
        
        User.exploreDelegate = self
        
        self.updateRecipes()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    private func updateRecipes() {
        self.recipes = Recipe.getMultiple(sortBy: .rating)
        //TODO - Do it with an animation
        self.tableView.reloadData()
    }
    
    deinit {
        User.exploreDelegate = nil
    }
}

extension RecipesViewController : UITableViewDataSource, UITableViewDelegate {
    
    
    //MARK : UITableViewDataSource
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let recipe = recipes?[indexPath.row] else {
            fatalError("Inconsistent State")
        }
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: RecipeViewCell.REUSE_ID, for: indexPath) as! RecipeViewCell
        cell.selectionStyle = .none
        cell.setContent(recipe)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes?.count ?? 0
    }
}

extension RecipesViewController : NotificationDelegate {
    func favoritesChanged() {
        //TODO - Change for more specific behavior
        //If we're not viewing the controller at this point, make sensse to update favorites
        if (self.navigationController as! HelloNavigationController).currrentTabItem() != 0 {
            self.updateRecipes()
        }
    }
    
    func ratingsChanged() {
        //TODO - Change for more specific behavior
        if (self.navigationController as! HelloNavigationController).currrentTabItem() != 0 {
            self.updateRecipes()
        }
    }
}
