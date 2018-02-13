//
//  FavoritesViewController.swift
//  HelloRecipe
//
//  Created by NTW-laptop on 12/02/18.
//  Copyright © 2018 Carlos Correia. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!  {
        didSet {
            tableView.separatorStyle = .none
            tableView.register(UINib(nibName: RecipeViewCell.REUSE_ID, bundle: Bundle.main), forCellReuseIdentifier: RecipeViewCell.REUSE_ID)
        }
    }
    
    var recipes : [Recipe]?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        User.favoritesDelegate = self
        
        self.navigationItem.title = "Favorites"
        
        favoritesChanged()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        User.favoritesDelegate = nil
    }


}

extension FavoritesViewController : UITableViewDataSource, UITableViewDelegate {
    
    
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

extension FavoritesViewController : NotificationDelegate {
    func favoritesChanged() {
        self.recipes = User.getUser()?.getFavorites(sortBy: .rating)
        //TODO - Do it with an animation
        self.tableView.reloadData()
    }
    
    func ratingsChanged() {
        //TODO - Change for more specific behavior
        if (self.navigationController as! HelloNavigationController).currrentTabItem() != 1 {
            self.recipes = User.getUser()?.getFavorites(sortBy: .rating)
            //TODO - Do it with an animation
            self.tableView.reloadData()
        }
    }
}

