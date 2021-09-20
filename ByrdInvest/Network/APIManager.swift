//
//  APIManager.swift
//  ByrdInvest
//
//  Created by Антон Тропин on 20.09.2021.
//

import Foundation


typealias JSONTask = URLSessionDataTask
typealias JSONCompletionHandler = (Data?, HTTPURLResponse?, Error?) -> Void

enum APIResult<T> {
	case Success(T)
	case Failure(Error)
}

protocol FinalURLPoint {
	var baseUrl: URL { get }
	var path: String { get }
	var request: URLRequest { get }
}

protocol APIManager {
	var sessionConfiguration: URLSessionConfiguration { get }
	var session: URLSession { get }
	
	func JSONTaskWith(request: URLRequest, completionHandler: @escaping JSONCompletionHandler) -> JSONTask
	func fetch<T>(request: URLRequest, parse: @escaping (Data) -> T?, completionHandler: @escaping (APIResult<T>) -> Void)
}

extension APIManager {
	
	func JSONTaskWith(request: URLRequest, completionHandler: @escaping JSONCompletionHandler) -> JSONTask {
		let dataTask = session.dataTask(with: request) { (data, response, error) in
			guard let HTTPResponse = response as? HTTPURLResponse else {
				let userInfo = [NSLocalizedDescriptionKey: NSLocalizedString("Missing HTTP Response", comment: "")]
				let error = NSError(domain: BBNetworkingErrorDomain, code: 100, userInfo: userInfo)
				completionHandler(nil, nil, error)
				return
			}
			if data == nil {
				if let error = error {
					completionHandler(nil, HTTPResponse, error)
				}
			} else {
				switch HTTPResponse.statusCode {
					case 200:
						completionHandler(data, HTTPResponse, nil)
					default:
						print("We have got Response Status: \(HTTPResponse.statusCode)")
				}
			}
		}
		return dataTask
	}
	
	func fetch<T>(request: URLRequest, parse: @escaping (Data) -> T?, completionHandler: @escaping (APIResult<T>) -> Void) {
		let dataTask = JSONTaskWith(request: request) { json, response, error in
			guard let json = json else {
				if let error = error {
					completionHandler(.Failure(error))
				}
				return
			}
			if let value = parse(json) {
				completionHandler(.Success(value))
			} else {
				let error = NSError(domain: BBNetworkingErrorDomain, code: 200, userInfo: nil)
				completionHandler(.Failure(error))
			}
		}
		dataTask.resume()
	}
	
}
