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
}

protocol RocketsListViewModelOutputType {
	var title: Driver<String> { get }
	var rockets: Driver<[Rocket]?> { get }
	var showLoading: Driver<Bool> { get }
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
	
	init() {
		print("RocketsListViewModel initialized")
	}
	
	private func fetchRockets() {
		_showLoading.accept(true)
		let request = AF.request("https://api.spacexdata.com/v4/rockets")
		request.responseDecodable(of: [Rocket].self) { [weak self] (response) in
			switch response.result {
				case .success(let rockets):
					self?._rockets.accept(rockets)
				case .failure(let error):
					assertionFailure("Error: \(error) when trying to fetch rockets")
					return
			}
			self?._showLoading.accept(false)
		}
	}
}
