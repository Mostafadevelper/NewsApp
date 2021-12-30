//
//  MainCoordinator.swift
//  NewsApp
//
//  Created by Mostafa on 30/12/2021.
//

import UIKit

class MainCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = [Coordinator]()
    var naviagtionController: UINavigationController
    
    func start() {
        let homeVC = HomeVC.instatiate(StoryboardName.home)
        homeVC.coordinator = self
        self.naviagtionController.pushViewController(homeVC, animated: false)
    }
    
    init(naviagtionController: UINavigationController){
        self.naviagtionController = naviagtionController
        self.naviagtionController.navigationBar.isHidden = true
    }
    
    func openDetails(article: HomeCellViewModel?){
        let detailsVC = DetailsVC.instatiate(StoryboardName.home)
        detailsVC.viewModel.article = article
        detailsVC.coordinator = self
        self.naviagtionController.pushViewController(detailsVC, animated: true)
    }
    
    func popUpDetailsVC(){
        self.naviagtionController.popViewController(animated: true)
    }
    
    func loadFavorite(){
        let favoriteVC = FavoriteVC.instatiate(StoryboardName.favorite)
        favoriteVC.coordinator = self
        self.naviagtionController.present(favoriteVC, animated: true)

    }
    
    func dismissFavorite(){
        self.naviagtionController.dismiss(animated: true)

    }
}
