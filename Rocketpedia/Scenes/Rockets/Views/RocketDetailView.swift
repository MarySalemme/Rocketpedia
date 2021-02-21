//
//  RocketDetailView.swift
//  Rocketpedia
//
//  Created by Mary Salemme on 21/02/2021.
//

import SwiftUI

struct RocketDetailView: View {
	var rocket: Rocket

    var body: some View {
		VStack(alignment: .leading) {
			UrlImageView(rocket.flickrImages.first ?? "")
			getSuccessRate().font(.system(size: 18, weight: .bold, design: .default))
			Text("Is active? \(rocket.active ? "YES" : "NO")")
			Text("Country: \(rocket.country)").font(.system(size: 18, weight: .regular, design: .default))
			Text(rocket.rocketDescription)
			Text("First flight: \(rocket.firstFlight)")
			Text("Cost per launch: \(rocket.costPerLaunch)$")
			Spacer()
		}.padding()
		.navigationBarTitle(Text(rocket.name), displayMode: .inline)
		Link("Open in Wikipedia", destination: URL(string: rocket.wikipedia)!)
		
    }
	
	private func getSuccessRate() -> Text {
		switch rocket.successRatePct {
			case 60...100:
				return Text("\(String(rocket.successRatePct))% success rate")
					.foregroundColor(.green)
			case 30...59:
				return Text("\(String(rocket.successRatePct))% success rate")
					.foregroundColor(.orange)
			case 0...29:
				return Text("\(String(rocket.successRatePct))% success rate")
					.foregroundColor(.red)
			default:
				return Text("Unknown success rate")
		}
	}
}

struct RocketView_Previews: PreviewProvider {
    static var previews: some View {
		NavigationView {
			RocketDetailView(rocket: Rocket(flickrImages: ["https://imgur.com/DaCfMsj.jpg", "https://imgur.com/azYafd8.jpg"], name: "Falcon 1", active: false, costPerLaunch: 6700000, successRatePct: 40, firstFlight: "2006-03-24", country: "Republic of the Marshall Islands", wikipedia: "https://en.wikipedia.org/wiki/Falcon_1", rocketDescription: "The Falcon 1 was an expendable launch system privately developed and manufactured by SpaceX during 2006-2009. On 28 September 2008, Falcon 1 became the first privately-developed liquid-fuel launch vehicle to go into orbit around the Earth.", id: "5e9d0d95eda69955f709d1eb"))
		}
    }
}
