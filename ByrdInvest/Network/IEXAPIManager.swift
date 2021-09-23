//
//  IEXAPIManager.swift
//  ByrdInvest
//
//  Created by Антон Тропин on 20.09.2021.
//

import Foundation


//MARK: - Enum IEX DataType

enum DataType: FinalURLPoint {
	case Company(apiKey: String, ticker: String)
	case Quote(apiKey: String, ticker: String)
	case List(apiKey: String, type: String)
	case Stats(apiKey: String, ticker: String)
	case Logo(apiKey: String, ticker: String)
	case PeerGroup(apiKey: String, ticker: String)

	var baseUrl: URL {
		return URL(string: "https://cloud.iexapis.com/stable/")!
	}

	var path: String {
		switch self {
			case .Company(apiKey: let apiKey, ticker: let ticker):
				return "stock/\(ticker)/company?" + apiKey
			case .Quote(apiKey: let apiKey, ticker: let ticker):
				return "stock/\(ticker)/quote?" + apiKey
			case .List(apiKey: let apiKey, type: let type):
				return "stock/market/list/\(type)?" + apiKey
			case .Stats(apiKey: let apiKey, ticker: let ticker):
				return "stock/\(ticker)/stats?" + apiKey
			case .Logo(apiKey: let apiKey, ticker: let ticker):
				return "stock/\(ticker)/logo?" + apiKey
			case .PeerGroup(apiKey: let apiKey, ticker: let ticker):
				return "stock/\(ticker)/peers?" + apiKey
		}
	}

	var request: URLRequest {
		let url = URL(string: path, relativeTo: baseUrl)
		return URLRequest(url: url!)
	}
}


//MARK: - Class IEXAPIManager

final class IEXAPIManager: APIManager {
	
	
	//Properties
	
	let sessionConfiguration: URLSessionConfiguration
	lazy var session: URLSession = {
		return URLSession(configuration: sessionConfiguration)
	}()
	let apiKey: String

	
	//Initialization
	
	init(sessionConfiguration: URLSessionConfiguration, apiKey: String){
		self.sessionConfiguration = sessionConfiguration
		self.apiKey = apiKey
	}

	convenience init(apiKey: String) {
		self.init(sessionConfiguration: URLSessionConfiguration.default, apiKey: apiKey)
	}

	
	//Methods
	
	//Company: name, city, country, sector, employees
	func fetchCompany(ticker: String, completionHandler: @escaping (Result<Company, Error>) -> Void) {
		let request = DataType.Company(apiKey: self.apiKey, ticker: ticker).request
		
		fetch(request: request, parse: { (data) -> Company? in
			guard let company = try? JSONDecoder().decode(Company.self, from: data) else {
				print("Error: can't parse Company")
				return nil
			}
			return company
		}, completionHandler: completionHandler)
	}

	//Quote: latest price, open price, close price
	func fetchQuote(ticker: String, completionHandler: @escaping (Result<Quote, Error>) -> Void) {
		let request = DataType.Quote(apiKey: self.apiKey, ticker: ticker).request
		
		fetch(request: request, parse: { (data) -> Quote? in
			guard let quote = try? JSONDecoder().decode(Quote.self, from: data) else {
				print("Error: can't parse Quote")
				return nil
			}
			return quote
		}, completionHandler: completionHandler)
	}

	
	//List: gainers, loosers, most active
	func fetchList(type: String, completionHandler: @escaping (Result<[List], Error>) -> Void) {
		let request = DataType.List(apiKey: self.apiKey, type: type).request
		
		fetch(request: request, parse: { (data) -> [List]? in
			guard let list = try? JSONDecoder().decode([List].self, from: data) else {
				print("Error: can't parse List")
				return nil
			}
			return list
		}, completionHandler: completionHandler)
	}
	
	//Stats: full company economic data
	func fetchStats(ticker: String, completionHandler: @escaping (Result<Stats, Error>) -> Void) {
		let request = DataType.Stats(apiKey: self.apiKey, ticker: ticker).request
		
		fetch(request: request, parse: { (data) -> Stats? in
			guard let stats = try? JSONDecoder().decode(Stats.self, from: data) else {
				print("Error: can't parse Stats")
				return nil
			}
			return stats
		}, completionHandler: completionHandler)
	}
	
}
