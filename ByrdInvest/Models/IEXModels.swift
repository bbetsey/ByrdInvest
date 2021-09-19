//
//  IEXModels.swift
//  ByrdInvest
//
//  Created by Антон Тропин on 08.09.2021.
//

import Foundation


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
	
	static func getStartFavouriteCompanies() -> [String] {
		["AAPL", "NFLX", "TSLA"]
	}
}

enum IEXRequest {
	case company
	case logo
	case stats
	case peerGroup
	case quote
	case list
	
	func getUrlRequest(data: String) -> String {
		switch self {
			case .company:
				return baseUrl + "/stock/\(data)/company?" + token
			case .logo:
				return baseUrl + "/stock/\(data)/logo?" + token
			case .stats:
				return baseUrl + "/stock/\(data)/stats?" + token
			case .peerGroup:
				return baseUrl + "/stock/\(data)/peers?" + token
			case .quote:
				return baseUrl + "/stock/\(data)/quote?" + token
			case .list:
				return baseUrl + "/stock/market/list/\(data)?" + token
		}
	}
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
