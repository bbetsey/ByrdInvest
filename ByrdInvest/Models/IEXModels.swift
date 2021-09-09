//
//  IEXModels.swift
//  ByrdInvest
//
//  Created by Антон Тропин on 08.09.2021.
//

import Foundation


struct ListElem: Decodable {
	
	let companyName: String
	let symbol: String
	let latestPrice: Double
	let previousClose: Double
	
	var priceChange: Double {
		Double(round((latestPrice - previousClose) / (previousClose / 100) * 100) / 100)
	}
	
	static func getList() -> [ListElem] {
		[
			ListElem(companyName: "Apple", symbol: "AAPL", latestPrice: 153.3, previousClose: 154.1),
			ListElem(companyName: "Google", symbol: "GOOG", latestPrice: 2345.5, previousClose: 2360.1),
			ListElem(companyName: "Tesla", symbol: "TSLA", latestPrice: 632.56, previousClose: 665.7),
			ListElem(companyName: "Netflix", symbol: "NFLX", latestPrice: 602.16, previousClose: 600.5)
		]
	}
	
}

struct Logo: Decodable {
	let url: String
}
