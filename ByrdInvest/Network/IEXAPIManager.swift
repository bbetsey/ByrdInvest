//
//  IEXAPIManager.swift
//  ByrdInvest
//
//  Created by Антон Тропин on 20.09.2021.
//

import Foundation


//MARK: - Enum DataType

enum DataType: FinalURLPoint {
	case Company(apiKey: String, ticker: String)
	case Quote(apiKey: String, ticker: String)
	case List(apiKey: String, type: String)
	case Stats(apiKey: String, ticker: String)
	case Logo(apiKey: String, ticker: String)
	case PeerGroup(apiKey: String, ticker: String)
	
	var baseUrl: URL {
		return URL(string: "https://cloud.iexapis.com/stable")!
	}
	
	var path: String {
		switch self {
			case .Company(apiKey: let apiKey, ticker: let ticker):
				return "/stock/\(ticker)/company?" + apiKey
			case .Quote(apiKey: let apiKey, ticker: let ticker):
				return "/stock/\(ticker)/quote?" + apiKey
			case .List(apiKey: let apiKey, type: let type):
				return "/stock/market/list/\(type)?" + apiKey
			case .Stats(apiKey: let apiKey, ticker: let ticker):
				return "/stock/\(ticker)/stats?" + apiKey
			case .Logo(apiKey: let apiKey, ticker: let ticker):
				return "/stock/\(ticker)/logo?" + apiKey
			case .PeerGroup(apiKey: let apiKey, ticker: let ticker):
				return "/stock/\(ticker)/peers?" + apiKey
		}
	}
	
	var request: URLRequest {
		let url = URL(string: path, relativeTo: baseUrl)
		return URLRequest(url: url!)
	}
}


//MARK: - Class IEXAPIManager

final class IEXAPIManager: APIManager {
	let sessionConfiguration: URLSessionConfiguration
	lazy var session: URLSession = {
		return URLSession(configuration: sessionConfiguration)
	} ()
	let apiKey: String
	
	init(sessionConfiguration: URLSessionConfiguration, apiKey: String){
		self.sessionConfiguration = sessionConfiguration
		self.apiKey = apiKey
	}
	
	convenience init(apiKey: String) {
		self.init(sessionConfiguration: URLSessionConfiguration.default, apiKey: apiKey)
	}
	
	func fetchCompany(ticker: String, completionHandler: @escaping (APIResult<Company>) -> Void) {
		let request = DataType.Company(apiKey: self.apiKey, ticker: ticker).request
		
		fetch(request: request, parse: { (data) -> Company? in
			guard let company = try? JSONDecoder().decode(Company.self, from: data) else {
				print("Error: can't parse Company")
				return nil
			}
			return company
		}, completionHandler: completionHandler)
	}
	
	func fetchQuote(ticker: String, completionHandler: @escaping (APIResult<Quote>) -> Void) {
		let request = DataType.Quote(apiKey: self.apiKey, ticker: ticker).request
		
		fetch(request: request, parse: { (data) -> Quote? in
			guard let quote = try? JSONDecoder().decode(Quote.self, from: data) else {
				print("Error: can't parse Quote")
				return nil
			}
			return quote
		}, completionHandler: completionHandler)
	}
	
}
