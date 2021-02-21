//
//  RocketsListViewController.swift
//  Rocketpedia
//
//  Created by Mary Salemme on 19/02/2021.
//

import UIKit
import RxSwift
import RxCocoa
import RxSwiftExt

class RocketsListViewController: UIViewController {

	// MARK: Subviews
	
	let activityIndicatorView: UIActivityIndicatorView
	
	let rocketsTableView: UITableView = {
		let tableView = UITableView()
		tableView.backgroundColor = UIColor.systemBackground
		tableView.translatesAutoresizingMaskIntoConstraints = false
		return tableView
	}()
	
	// MARK: Dependencies

	let viewModel: RocketsListViewModel
	
	private let _disposeBag = DisposeBag()

	// MARK: Initializers

	init(viewModel: RocketsListViewModel) {
		self.activityIndicatorView = UIActivityIndicatorView(style: .medium)
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
		setupUI()
		setupConstraints()
		setupBindings()
		print("RocketsListViewController initialized")
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		viewModel.inputs.viewDidAppear()
		super.viewDidAppear(animated)
	}

	func setupUI() {
		navigationController?.navigationBar.backgroundColor = .systemBackground
		navigationController?.navigationBar.isTranslucent = false
		view.backgroundColor = .systemBackground
		rocketsTableView.register(RocketCell.self, forCellReuseIdentifier: "RocketCell")
		view.addSubview(rocketsTableView)
		activityIndicatorView.center = self.view.center
		view.addSubview(activityIndicatorView)
	}
	
	func setupConstraints() {
		NSLayoutConstraint.activate([
			rocketsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			rocketsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			rocketsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			rocketsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
		])
	}
	
	func setupBindings() {
		viewModel.outputs.title
			.drive { (value) in
				self.title = value
			}
			.disposed(by: _disposeBag)
			
		viewModel.outputs.rockets
			.unwrap()
			.drive(rocketsTableView.rx.items(cellIdentifier: RocketCell.reuseIdentifier, cellType: RocketCell.self)) {
				_, rocket, cell in
				cell.name = rocket.name
				cell.firstFlight = rocket.firstFlight
				cell.imageUrl = rocket.flickrImages.first
				cell.successRate = rocket.successRatePct
			}
			.disposed(by: _disposeBag)
		
		viewModel.outputs.showLoading
			.drive(activityIndicatorView.rx.isAnimating)
			.disposed(by: _disposeBag)

		Observable.combineLatest(viewModel.outputs.showError.asObservable(), viewModel.outputs.errorMessage.asObservable().unwrap())
			.asObservable()
			.subscribe(onNext: { [weak self] (showError, errorMessage) in
				if showError {
					self?.showAlert(error: errorMessage)
				}
			})
			.disposed(by: _disposeBag)
		
		rocketsTableView.rx.modelSelected(Rocket.self)
			.bind(onNext: { [viewModel] (rocket) in
				viewModel.inputs.rocketTapped(rocket)
			})
			.disposed(by: _disposeBag)
	}
	
	private func showAlert(error: String) {
		let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
		alert.addAction(.init(title: "OK", style: .cancel, handler: .none))
		self.present(alert, animated: true)
	}
}
