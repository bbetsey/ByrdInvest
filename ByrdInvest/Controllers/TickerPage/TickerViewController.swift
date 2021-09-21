//
//  TickerViewController.swift
//  ByrdInvest
//
//  Created by Антон Тропин on 19.09.2021.
//

import UIKit

class TickerViewController: UIViewController {

	@IBOutlet var nameLabel: UILabel!
	
	var ticker: Quote!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		title = ticker.companyName
		nameLabel.text = ticker.symbol
	}

}
