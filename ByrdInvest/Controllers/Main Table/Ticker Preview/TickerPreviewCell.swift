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
	
	
	override func awakeFromNib() {
        super.awakeFromNib()
        
		logo.layer.cornerRadius = 10
    }
	
	private func getColor(changePrice: Double) -> UIColor {
		return changePrice < 0
			? UIColor.systemRed
			: UIColor.systemGreen
	}
	
	func setup(ticker: ListElem) {
		nameLabel.text = ticker.companyName
		tickerLabel.text = ticker.symbol
		priceLabel.text = "\(ticker.previousClose)"
		changeLabel.text = "\(ticker.priceChange)"
		changeLabel.textColor = getColor(changePrice: ticker.priceChange)
		logo.image = UIImage(named: ticker.symbol)
		
	}

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}


