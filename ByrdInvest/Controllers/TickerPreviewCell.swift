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
        
		logo.layer.cornerRadius = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
