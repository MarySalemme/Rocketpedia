//
//  RocketsListViewController.swift
//  Rocketpedia
//
//  Created by Mary Salemme on 19/02/2021.
//

import UIKit

class RocketsListViewController: UIViewController {
	
	// MARK: Dependencies

	let viewModel: RocketsListViewModel

	// MARK: Initializers

	init(viewModel: RocketsListViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
		print("RocketsListViewController initialized")
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
