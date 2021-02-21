//
//  String.swift
//  Rocketpedia
//
//  Created by Mary Salemme on 21/02/2021.
//

import Foundation

extension String {
	func formatDate() -> String {
		var stringToArray = self.components(separatedBy: "-")
		stringToArray.reverse()
		return stringToArray.joined(separator: "-")
	}
}
