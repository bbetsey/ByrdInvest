//
//  ListPreviewCell.swift
//  ByrdInvest
//
//  Created by Антон Тропин on 16.09.2021.
//

import UIKit

class ListPreviewCell: UICollectionViewCell {

	@IBOutlet var listPreviewImage: UIImageView!
	@IBOutlet var listName: UILabel!
	
	var image: UIImage!
	var name: String!
	
	override func awakeFromNib() {
        super.awakeFromNib()
        
		listPreviewImage.image = image
		listName.text = name
		
		listPreviewImage.layer.cornerRadius = 15
    }

}
