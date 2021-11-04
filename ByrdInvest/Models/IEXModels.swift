//
//  IEXModels.swift
//  ByrdInvest
//
//  Created by Антон Тропин on 08.09.2021.
//

import Foundation
import UIKit


//MARK: - Company Model

struct Company: Decodable {
	let symbol: String?
	let companyName: String?
	let exchange: String?
	let industry: String?
	let website: String?
	let description: String?
	let CEO: String?
	let sector: String?
	let employees: Int?
	let city: String?
	let country: String?
}


//MARK: - Quote Model

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


//MARK: - List Model

struct List: Decodable {
	let symbol: String
}


//MARK: - Stats Model

struct Stats: Decodable {
	let companyName: String?
	let marketcap: Double?
	let week52high: Double?
	let week52low: Double?
	let week52change: Double?
	let employees: Double?
	let ttmEPS: Double?
	let ttmDividendRate: Double?
	let dividendYield: Double?
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


//MARK: - Logo Model

struct Logo: Decodable {
	let url: String
}


//MARK: - List Preview Model

struct ListPreview {
	
	let name: String
	let requestName: String
	
	static func getListsPreview() -> [ListPreview] {
		[
			ListPreview(name: "Gainers", requestName: "gainers"),
			ListPreview(name: "Losers", requestName: "losers"),
			ListPreview(name: "Most Active", requestName: "mostactive")
		]
	}
	
}
