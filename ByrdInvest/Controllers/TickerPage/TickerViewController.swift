//
//  TickerViewController.swift
//  ByrdInvest
//
//  Created by Антон Тропин on 19.09.2021.
//

import UIKit

class TickerViewController: UIViewController {

	@IBOutlet var nameLabel: UILabel!
	@IBOutlet var companyLabels: [UILabel]!
	
	var ticker: Quote!
	
	var iexManager: IEXAPIManager!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		title = ticker.companyName
		nameLabel.text = ticker.symbol
		
		DispatchQueue.global().async {
			self.iexManager.fetchCompany(ticker: self.ticker.symbol) { (result) in
				switch result {
					case .success(let company):
						self.setCompany(for: company)
					case .failure(let error):
						let alertController = self.iexManager.alertController(title: "Unable to get data", message: "\(error.localizedDescription)", error: error)
						self.present(alertController, animated: true, completion: nil)
				}
			}
		}
	}

}

//MARK: - Network Methods

extension TickerViewController {
	
	private func setCompany(for company: Company) {
		companyLabels[0].text = company.industry
		companyLabels[1].text = company.sector
		companyLabels[2].text = company.exchange
		companyLabels[3].text = company.CEO
		companyLabels[4].text = company.city
		companyLabels[5].text = "\(company.employees)"
	}
	
}
