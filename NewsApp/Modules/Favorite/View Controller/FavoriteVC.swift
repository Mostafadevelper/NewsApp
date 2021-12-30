//
//  FavoriteVC.swift
//  NewsApp
//
//  Created by Mostafa on 30/12/2021.
//

import UIKit

class FavoriteVC: UIViewController {

    //MARK:- IBOutlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyFavoriteView: UIView!
    
    //MARK:- Variable:-
    var articles = [ArticleCoreData]()
    var articleMode: ArticleData! = ArticleData()
    weak var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
    
        self.articles = articleMode.getArticles()
        emptyFavorite()
    }
       
    @IBAction func dismissAction(_ sender: Any) {
        coordinator?.dismissFavorite()
    }
    
    func emptyFavorite() {
        emptyFavoriteView.isHidden = articles.isEmpty ? false:true

    }
    
}


extension FavoriteVC {
  
    func setupTableView() {
        tableView.register(cell: HomeTableCell.self)
        tableView.tableFooterView = UIView()
    }
    

}

//MARK:- Table View data Source
extension FavoriteVC :  UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeue() as HomeTableCell
        cell.newTitleLB.text = articles[indexPath.row].title
        cell.newIMG.loadImage(urlName: articles[indexPath.row].imageURl)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            
            self.articles.remove(at: indexPath.row)
            self.tableView.reloadData()
            articleMode.removeArticle(index: indexPath.row)
            emptyFavorite()
            
        }
    }

    
}

