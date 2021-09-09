//
//  IEXDataManager.swift
//  ByrdInvest
//
//  Created by Антон Тропин on 08.09.2021.
//

import Foundation
import UIKit


class IEXDataManager {
	
	let baseUrl = "https://cloud.iexapis.com/stable"
	let token = "token=sk_5320c60829e14e6f87422f719c829e89"
	
	private func getLogoUrl(for ticker: String, completion: @escaping (String) -> Void) {
		let urlString = baseUrl + "/stock/\(ticker)/logo?" + token
		guard let url = URL(string: urlString) else { return }
		let task = URLSession.shared.dataTask(with: url) { (data, response, error ) in
			guard error == nil else {
				print("Hlelo")
				print(error?.localizedDescription ?? "noDesc")
				return
			}
			guard let data = data else { return }
			guard let logoUrl = try? JSONDecoder().decode(Logo.self, from: data) else {
				print("Error: can't parse logoUrl")
				return
			}
			completion(logoUrl.url)
		}
		task.resume()
		
	}
	
	func getLogo(for ticker: String, completion: @escaping (UIImage) -> Void) {
		var urlString = ""
		getLogoUrl(for: ticker) { result in
			DispatchQueue.main.async {
				urlString = result
			}
		}
		print(urlString + "heee")
		guard let url = URL(string: urlString) else { return }
		let task = URLSession.shared.dataTask(with: url) { (data, response, error ) in
			guard error == nil else {
				completion(UIImage(named: "MOON")!)
				print(error?.localizedDescription ?? "noDesc")
				return
			}
			guard let data = data else { return }
			guard let image = UIImage(data: data) else { return }
			completion(image)
		}
		task.resume()
	}
	
	func getList(for type: String, completion: @escaping ([ListElem]) -> Void) {
		let urlString = baseUrl + "/stock/market/list/\(type)?" + token
		guard let url = URL(string: urlString) else { return }
		let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
			guard error == nil else {
				print(error?.localizedDescription ?? "noDesc")
				return
			}
			guard let data = data else { return }
			guard let list = try? JSONDecoder().decode([ListElem].self, from: data) else {
				print("Error: can't parse list")
				return
			}
			completion(list)
		}
		task.resume()
	}
	
}
