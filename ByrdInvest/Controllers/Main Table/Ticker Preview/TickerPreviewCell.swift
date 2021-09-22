//
//  TickerPreviewCell.swift
//  ByrdInvest
//
//  Created by Антон Тропин on 08.09.2021.
//

import UIKit

class TickerPreviewCell: UITableViewCell {

	
	@IBOutlet var nameLabel: UILabel!
	@IBOutlet var tickerLabel: UILabel!
	@IBOutlet var priceLabel: UILabel!
	@IBOutlet var changeLabel: UILabel!
	@IBOutlet var logo: UIImageView!
	@IBOutlet var container: UIView!
	
	func setup(ticker: Quote) {
		
		nameLabel.text = ticker.companyName
		tickerLabel.text = ticker.symbol
		priceLabel.text = ticker.latestPriceString
		changeLabel.text = ticker.changeString
		changeLabel.textColor = ticker.changeColor
		
		if let image = UIImage(named: ticker.symbol) {
			logo.image = image
		} else {
			logo.image = UIImage(named: "MOON")
		}
		setLogo()
		
	}
    
}

extension TickerPreviewCell {
	func setLogo() {
		container.layer.cornerRadius = 10
		container.layer.masksToBounds = false
		container.layer.shadowColor = UIColor.black.cgColor
		container.layer.shadowOffset = .zero
		container.layer.shadowOpacity = 0.15
		container.layer.shadowRadius = 5.0
		logo.frame = container.bounds
		logo.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		logo.layer.cornerRadius = 10
		container.addSubview(logo)
	}
}

