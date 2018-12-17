//
//  AppDelegate.swift
//  reduxNews
//
//  Created by Владимир Бондарь on 10/1/18.
//  Copyright © 2018 VladymyrBondar. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    let window = UIWindow()
    let network = NetworkClient(baseURL: URL(string: "https://newsapi.org/")!)
    let newsService = NewsService(networkClient: network)
    let viewModel = News.ViewModel(newsService: newsService)
    let viewController = News.ViewController(viewModel: viewModel)
    window.rootViewController = UINavigationController(rootViewController: viewController)
    window.makeKeyAndVisible()
    window.backgroundColor = .white
    self.window = window
    return true
  }
}
