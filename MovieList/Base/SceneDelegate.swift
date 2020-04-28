//
//  SceneDelegate.swift
//  MovieList
//
//  Created by Luiz F. A. Pio on 02/04/20.
//  Copyright © 2020 Luiz Felipe Albernaz Pio. All rights reserved.
//

import UIKit

var isRunningTests: Bool {
    NSClassFromString("XCTest") != nil
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        
        let movieListViewController = MovieListViewController()
        let presenter = MovieListPresenter()
        
        movieListViewController.presenter = presenter
        presenter.outputDelegate = movieListViewController
        
        if isRunningTests == false {
            self.window?.rootViewController = movieListViewController
            self.window?.makeKeyAndVisible()
        }
    }
}
