//
//  RocketsListViewModel.swift
//  Rocketpedia
//
//  Created by Mary Salemme on 19/02/2021.
//

import Foundation
import RxSwift
import RxCocoa

protocol RocketsListViewModelInputType {
	func viewDidAppear()
}

protocol RocketsListViewModelOutputType {
	var title: Driver<String> { get }
	var rockets: Driver<[Rocket]?> { get }
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
	
	init() {
		print("RocketsListViewModel initialized")
	}
	
	private func fetchRockets() {
		_rockets.accept([Rocket(name: "Foo", firstFlight: "2006-03-24"), Rocket(name: "Bar", firstFlight: "2006-03-24"), Rocket(name: "Joe", firstFlight: "2006-03-24")])
	}
}

struct Rocket {
	let name: String
	let firstFlight: String
}
