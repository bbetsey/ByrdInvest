//
//  IEXModels.swift
//  ByrdInvest
//
//  Created by Антон Тропин on 08.09.2021.
//

import Foundation


struct ListElem {
	
	let companyName: String
	let symbol: String
	let open: Double
	let close: Double
	
	var priceChange: Double {
		Double(round((open - close) / (open / 100) * 100) / 100)
	}
	
	static func getList() -> [ListElem] {
		[
			ListElem(companyName: "Apple", symbol: "AAPL", open: 153.3, close: 154.1),
			ListElem(companyName: "Google", symbol: "GOOG", open: 2345.5, close: 2360.1),
			ListElem(companyName: "Tesla", symbol: "TSLA", open: 632.56, close: 665.7)
		]
	}
	
}
