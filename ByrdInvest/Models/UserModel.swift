//
//  UserModel.swift
//  ByrdInvest
//
//  Created by Антон Тропин on 19.09.2021.
//

import Foundation


struct User {
	
	let name: String
	let login: String
	let pass: String
	let favouriteTickers: [String]?
	let favouriteCompanies: [Company]?
	
	static func getUser() -> User {
		User(
			name: "Anton",
			login: "bbetsey",
			pass: "qwerty",
			favouriteTickers: ["AAPL", "NFLX", "TSLA"],
			favouriteCompanies: nil
		)
	}
}
