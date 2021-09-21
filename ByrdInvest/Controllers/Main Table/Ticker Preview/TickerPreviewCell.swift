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
	
	private func getColor(changePrice: Double) -> UIColor {
		return changePrice < 0
			? UIColor.systemRed
			: UIColor.systemGreen
	}
	
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
		logo.layer.cornerRadius = 10
		
	}

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}


