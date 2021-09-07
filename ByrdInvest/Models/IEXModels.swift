//
//  IEXModels.swift
//  ByrdInvest
//
//  Created by Антон Тропин on 08.09.2021.
//

import Foundation


struct Company {
	
	let name: String
	let ticker: String
	
	static func getCompanies() -> [Company] {
		[
			Company(name: "Apple", ticker: "AAPL"),
			Company(name: "Microsoft", ticker: "MSFT"),
			Company(name: "Google", ticker: "GOOG"),
			Company(name: "Amazon", ticker: "AMZN"),
			Company(name: "Netflix", ticker: "NFLX")
		]
	}
}
