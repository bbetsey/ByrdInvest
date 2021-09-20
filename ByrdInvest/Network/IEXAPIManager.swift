//
//  IEXAPIManager.swift
//  ByrdInvest
//
//  Created by Антон Тропин on 20.09.2021.
//

import Foundation

enum DataType: FinalURLPoint {
	case Company(apiKey: String, ticker: String)
	
	var baseUrl: URL {
		return URL(string: "https://cloud.iexapis.com/stable")!
	}
	
	var path: String {
		switch self {
			case .Company(apiKey: let apiKey, ticker: let ticker):
				return "/stock/\(ticker)/company?" + apiKey
		}
	}
	
	var request: URLRequest {
		let url = URL(string: path, relativeTo: baseUrl)
		return URLRequest(url: url!)
	}
	
	
	
	
}

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
}
