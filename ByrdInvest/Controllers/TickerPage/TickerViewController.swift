//
//  TickerViewController.swift
//  ByrdInvest
//
//  Created by Антон Тропин on 19.09.2021.
//

import UIKit

class TickerViewController: UIViewController {

	@IBOutlet var nameLabel: UILabel!
	
	var ticker: ListElem!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		title = ticker.companyName
		nameLabel.text = ticker.symbol
	}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
