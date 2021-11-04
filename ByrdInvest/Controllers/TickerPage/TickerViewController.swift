//
//  TickerViewController.swift
//  ByrdInvest
//
//  Created by Антон Тропин on 19.09.2021.
//

import UIKit

class TickerViewController: UIViewController {

	@IBOutlet var companyLabels: [UILabel]!
	@IBOutlet var logoImage: UIImageView!
	@IBOutlet var imagePalette: UIView!
	@IBOutlet var marketCapLabel: UILabel!
	@IBOutlet var peRatioLabel: UILabel!
	@IBOutlet var descriptionLabel: UILabel!
	
	var ticker: Quote!
	
	var iexManager: IEXAPIManager!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		title = ticker.companyName
		
		DispatchQueue.global().async {
			self.getCompanyInfo(for: self.ticker.symbol)
			self.getLogoURL(for: self.ticker.symbol)
			self.getStats(for: self.ticker.symbol)
		}
	}

}

//MARK: - Network Methods

extension TickerViewController {
	
	private func setLogo() {
		imagePalette.layer.cornerRadius = 15
		imagePalette.layer.masksToBounds = false
		imagePalette.layer.shadowColor = UIColor.black.cgColor
		imagePalette.layer.shadowOffset = .zero
		imagePalette.layer.shadowOpacity = 0.3
		imagePalette.layer.shadowRadius = 5.0
		logoImage.frame = imagePalette.bounds
		logoImage.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		logoImage.layer.cornerRadius = 15
		imagePalette.addSubview(logoImage)
	}
	
	private func setCompany(for company: Company) {
		companyLabels[0].text = company.industry?.isEmpty ?? false ? "-" : company.industry
		companyLabels[1].text = company.sector?.isEmpty ?? false ? "-" : company.sector
		companyLabels[2].text = company.exchange?.isEmpty ?? false ? "-" : company.exchange
		companyLabels[3].text = company.CEO?.isEmpty ?? false ? "-" : company.CEO
		companyLabels[4].text = company.city?.isEmpty ?? false ? "-" : company.city
		companyLabels[5].text = "\(company.employees ?? 0)"
		companyLabels[6].text = company.symbol?.isEmpty ?? false ? "-" : company.symbol
		descriptionLabel.text = company.description?.isEmpty ?? false ? "none" : company.description
	}
	
	private func getStats(for ticker: String) {
		iexManager.fetchStats(ticker: ticker) { (result) in
			switch result {
				case .success(let stats):
					self.marketCapLabel.text = "\(Int((stats.marketcap ?? 0) / 1000000000))B"
					self.peRatioLabel.text = "\(Int(stats.peRatio ?? 0))"
				case .failure(let error):
					let alertController = self.iexManager.alertController(title: "Unable to get data", message: "\(error.localizedDescription)", error: error)
					self.present(alertController, animated: true, completion: nil)
			}
		}
	}
	
	private func getCompanyInfo(for ticker: String) {
		iexManager.fetchCompany(ticker: ticker) { (result) in
			switch result {
				case .success(let company):
					self.setCompany(for: company)
				case .failure(let error):
					let alertController = self.iexManager.alertController(title: "Unable to get data", message: "\(error.localizedDescription)", error: error)
					self.present(alertController, animated: true, completion: nil)
			}
		}
	}
	
	private func getLogoURL(for ticker: String) {
		iexManager.fetchLogoUrl(ticker: ticker) { result in
			switch result {
				case .success(let logoURL):
					self.getLogo(logoURL: logoURL.url)
					self.setLogo()
				case .failure(let error):
					print(error)
			}
		}
	}
	
	private func getLogo(logoURL: String) {
		iexManager.fetchLogo(url: logoURL) { result in
			switch result {
				case .success(let logo):
					self.logoImage.image = logo
				case .failure(let error):
					print(error)
			}
		}
	}
	
}
