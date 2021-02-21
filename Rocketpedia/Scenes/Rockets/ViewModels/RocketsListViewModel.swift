//
//  RocketsListViewModel.swift
//  Rocketpedia
//
//  Created by Mary Salemme on 19/02/2021.
//

import RxSwift
import RxCocoa
import Alamofire

protocol RocketsListViewModelInputType {
	func viewDidAppear()
	func rocketTapped(_ rocket: Rocket)
}

protocol RocketsListViewModelOutputType {
	var title: Driver<String> { get }
	var rockets: Driver<[Rocket]?> { get }
	var showLoading: Driver<Bool> { get }
	var showError: Driver<Bool> { get }
	var errorMessage: Driver<String?> { get }
}

protocol RocketsListViewModelType {
	var inputs: RocketsListViewModelInputType { get }
	var outputs: RocketsListViewModelOutputType { get }
}

class RocketsListViewModel: RocketsListViewModelType, RocketsListViewModelInputType, RocketsListViewModelOutputType {
	
	var inputs: RocketsListViewModelInputType {
		return self
	}
	
	func viewDidAppear() {
		fetchRockets()
	}
	
	func rocketTapped(_ rocket: Rocket) {
		coordinator.rocketSelected(rocket)
	}
	
	var outputs: RocketsListViewModelOutputType {
		return self
	}
	
	private var _title = BehaviorRelay<String>(value: "Rockets")
	var title: Driver<String> {
		return _title.asDriver()
	}
	
	private var _rockets = BehaviorRelay<[Rocket]?>(value: nil)
	var rockets: Driver<[Rocket]?> {
		return _rockets.asDriver()
	}
	
	private var _showLoading = BehaviorRelay<Bool>(value: false)
	var showLoading: Driver<Bool> {
		return _showLoading.asDriver()
	}
	
	private var _showError = BehaviorRelay<Bool>(value: false)
	var showError: Driver<Bool> {
		return _showError.asDriver()
	}
	
	private var _errorMessage = BehaviorRelay<String?>(value: nil)
	var errorMessage: Driver<String?> {
		return _errorMessage.asDriver()
	}
	
	var coordinator: AppCoordinator
	
	init(coordinator: AppCoordinator) {
		self.coordinator = coordinator
	}
	
	private func fetchRockets() {
		_showLoading.accept(true)
		let request = AF.request("https://api.spacexdata.com/v4/rockets")
		request.responseDecodable(of: [Rocket].self) { [weak self] (response) in
			switch response.result {
				case .success(let rockets):
					self?._rockets.accept(rockets)
					self?._showLoading.accept(false)
				case .failure(let error):
					self?._showError.accept(true)
					self?._errorMessage.accept(error.localizedDescription)
					self?._showLoading.accept(false)
					assertionFailure("Error: \(error.localizedDescription)")
			}
		}
	}
}
