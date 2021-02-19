//
//  SceneDelegate.swift
//  Rocketpedia
//
//  Created by Mary Salemme on 19/02/2021.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?
	private var appCoordinator: AppCoordinator?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		if let windowScene = scene as? UIWindowScene {
		    let window = UIWindow(windowScene: windowScene)
			self.appCoordinator = AppCoordinator(window: window)
		    window.rootViewController = appCoordinator?.rootViewController
		    self.window = window
		    window.makeKeyAndVisible()
			
			appCoordinator?.start()
		}
	}
}
