//
//  IEXModels.swift
//  ByrdInvest
//
//  Created by Антон Тропин on 08.09.2021.
//

import Foundation
import UIKit


private let baseUrl = "https://cloud.iexapis.com/stable"
private let token = "token=pk_fb749936d92541fa8d916d36db253dc0"

struct Company: Decodable {
	let symbol: String
	let companyName: String
	let exchange: String
	let industry: String
	let website: String
	let description: String
	let CEO: String
	let sector: String
	let employees: Int
	let city: String
	let country: String
}

struct Quote: Decodable {
	let symbol: String
	let companyName: String
	let latestPrice: Double?
	let open: Double?
	let change: Double?
	
	var latestPriceString: String {
		"$\(round((latestPrice ?? 0) * 10) / 10)"
	}
	var changeString: String {
		"\(abs(round((change ?? 0) * 10) / 10))%"
	}
	var changeColor: UIColor {
		return (change ?? 0) < 0
			? UIColor.systemRed
			: UIColor.systemGreen
	}
}

struct List: Decodable {
	let symbol: String
}

struct Stats: Decodable {
	let companyName: String
	let marketCap: Double?
	let week52high: Double
	let week52low: Double
	let week52change: Double
	let employees: Double
	let ttmEPS: Double
	let ttmDividendRate: Double
	let dividendYield: Double
	let nextDividendDate: String?
	let exDividendDate: String?
	let nextEarningsDate: String?
	let peRatio: Double?
	let beta: Double?
	let year5ChangePercent: Double?
	let year2ChangePercent: Double?
	let year1ChangePercent: Double?
	let ytdChangePercent: Double?
	let month6ChangePercent: Double?
	let month3ChangePercent: Double?
	let month1ChangePercent: Double?
	let day30ChangePercent: Double?
	let day5ChangePercent: Double?
}


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
			ListElem(companyName: "Microsoft", symbol: "MSFT", latestPrice: 602.16, previousClose: 600.5)
		]
	}
	
}

struct Logo: Decodable {
	let url: String
}

struct ListPreview {
	
	let name: String
	
	static func getListsPreview() -> [ListPreview] {
		[
			ListPreview(name: "Gainers"),
			ListPreview(name: "Loosers"),
			ListPreview(name: "Most Active")
		]
	}
	
}
