//
//  CustomHeader.swift
//  ByrdInvest
//
//  Created by Антон Тропин on 23.09.2021.
//

import UIKit

class CustomHeader: UITableViewHeaderFooterView {
	
	var title: String!
	let titleLabel = UILabel()
	
	
	override init(reuseIdentifier: String?) {
			super.init(reuseIdentifier: reuseIdentifier)
			configureContents()
		}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override var reuseIdentifier: String {
		"CustomHeader"
	}
	
	func configureContents() {
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		contentView.addSubview(titleLabel)
		
		NSLayoutConstraint.activate([
			titleLabel.leadingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 16),
			titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 16),
			titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
		])

		titleLabel.font = UIFont(name: "System Bold", size: 25)
		titleLabel.text = title
		self.backgroundColor = .white
	}

}
