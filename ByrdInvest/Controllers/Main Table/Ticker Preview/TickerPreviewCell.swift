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
	
	lazy var iexManager = IEXAPIManager(apiKey: "token=pk_fb749936d92541fa8d916d36db253dc0")
	
	func setup(ticker: Quote) {
		
		nameLabel.text = ticker.companyName
		tickerLabel.text = ticker.symbol
		priceLabel.text = ticker.latestPriceString
		changeLabel.text = ticker.changeString
		changeLabel.textColor = ticker.changeColor
		
		logo.image = UIImage(named: "MOON")
		getLogoURL(ticker: ticker.symbol)
		setLogo()
		
	}
	
	func getLogoURL(ticker: String) {
		iexManager.fetchLogoUrl(ticker: ticker) { result in
			switch result {
				case .success(let logoURL):
					self.getLogo(logoURL: logoURL.url)
				case .failure(let error):
					print(error)
			}
		}
	}
	
	func getLogo(logoURL: String) {
		iexManager.fetchLogo(url: logoURL) { result in
			switch result {
				case .success(let logo):
					self.logo.image = logo
					self.setNeedsLayout()
				case .failure(let error):
					print(error)
			}
		}
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

