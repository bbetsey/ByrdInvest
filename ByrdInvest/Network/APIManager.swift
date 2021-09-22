//
//  APIManager.swift
//  ByrdInvest
//
//  Created by Антон Тропин on 20.09.2021.
//

import Foundation
import UIKit


typealias JSONTask = URLSessionDataTask
typealias JSONCompletionHandler = (Data?, HTTPURLResponse?, Error?) -> Void


//MARK: - Protocol FinalURLPoint

protocol FinalURLPoint {
	var baseUrl: URL { get }
	var path: String { get }
	var request: URLRequest { get }
}


//MARK: - Protocol APIManager

protocol APIManager {
	var sessionConfiguration: URLSessionConfiguration { get }
	var session: URLSession { get }
	
	func JSONTaskWith(request: URLRequest, completionHandler: @escaping JSONCompletionHandler) -> JSONTask
	func fetch<T>(request: URLRequest, parse: @escaping (Data) -> T?, completionHandler: @escaping (APIResult<T>) -> Void)
}


//MARK: - Protocol APIManager Extension

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
	
	func fetch<T>(request: URLRequest, parse: @escaping (Data) -> T?, completionHandler: @escaping (Result<T, Error>) -> Void) {
		let dataTask = JSONTaskWith(request: request) { json, response, error in
			DispatchQueue.main.async {
				guard let json = json else {
					if let error = error {
						completionHandler(.failure(error))
					}
					return
				}
				if let value = parse(json) {
					completionHandler(.success(value))
				} else {
					let error = NSError(domain: BBNetworkingErrorDomain, code: 200, userInfo: nil)
					completionHandler(.failure(error))
				}
			}
		}
		dataTask.resume()
	}
	
	func alertController(title: String, message: String, error: Error) -> UIAlertController {
		let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
		let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
		alertController.addAction(okAction)
		return alertController
	}
	
}
