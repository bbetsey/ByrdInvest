//
//  HeaderCell.swift
//  ByrdInvest
//
//  Created by Антон Тропин on 18.09.2021.
//

import UIKit

class HeaderCell: UITableViewCell {

	@IBOutlet var titleLabel: UILabel!
	var sectionName: String!
	
	func setup(title: String) {
		titleLabel.text = sectionName
	}
    
}
