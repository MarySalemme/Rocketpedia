//
//  AppCoordinator.swift
//  Rocketpedia
//
//  Created by Mary Salemme on 19/02/2021.
//

import UIKit
import SwiftUI

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
		let rocketsListViewModel = RocketsListViewModel(coordinator: self)
		let rocketsListViewController = RocketsListViewController(viewModel: rocketsListViewModel)
		rootViewController.pushViewController(rocketsListViewController, animated: false)
	}
	
	func rocketSelected(_ rocket: Rocket) {
		let rocketDetailView = RocketDetailView(rocket: rocket)
		let hostingController = UIHostingController(rootView: rocketDetailView)
		rootViewController.pushViewController(hostingController, animated: false)
	}
}
