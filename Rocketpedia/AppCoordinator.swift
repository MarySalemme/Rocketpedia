//
//  AppCoordinator.swift
//  Rocketpedia
//
//  Created by Mary Salemme on 19/02/2021.
//

import UIKit

protocol Coordinator {
	func start()
}

class AppCoordinator: Coordinator {
	private let window: UIWindow
	let rootViewController: UINavigationController
	
	init(window: UIWindow) {
		self.window = window
		rootViewController = UINavigationController()
	}
	
	func start() {
		window.rootViewController = rootViewController
		window.makeKeyAndVisible()
		
		let rocketsListViewModel = RocketsListViewModel()
		let rocketsListViewController = RocketsListViewController(viewModel: rocketsListViewModel)
		
		rootViewController.pushViewController(rocketsListViewController, animated: false)
	}

}
