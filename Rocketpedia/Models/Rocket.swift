//
//  Rocket.swift
//  Rocketpedia
//
//  Created by Mary Salemme on 20/02/2021.
//

struct Rocket: Decodable {
	let flickrImages: [String]
	let name: String
	let active: Bool
	let costPerLaunch, successRatePct: Int
	let firstFlight, country: String
	let wikipedia: String
	let rocketDescription, id: String

	enum CodingKeys: String, CodingKey {
		case flickrImages = "flickr_images"
		case name, active
		case costPerLaunch = "cost_per_launch"
		case successRatePct = "success_rate_pct"
		case firstFlight = "first_flight"
		case country, wikipedia
		case rocketDescription = "description"
		case id
	}
}
