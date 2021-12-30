//
//  AppDelegate.swift
//  NewsApp
//
//  Created by Mostafa on 30/12/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    var mainVC: MainCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.loadApp()
        return true
    }

    private func loadApp(){
        let navigationController = UINavigationController()
        mainVC = MainCoordinator(naviagtionController: navigationController)
        mainVC.start()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }



}

