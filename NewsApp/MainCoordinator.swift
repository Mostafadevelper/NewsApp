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
    
}
