//
//  ListsCollectionViewCell.swift
//  ByrdInvest
//
//  Created by Антон Тропин on 17.09.2021.
//

import UIKit

class ListsCollectionViewCell: UICollectionViewCell {

	@IBOutlet var previewImage: UIImageView!
	@IBOutlet var previewName: UILabel!
	@IBOutlet var palette: UIView!
	
	override func awakeFromNib() {
        super.awakeFromNib()
    }
	
	func setup(list: ListPreview) {
		previewName.text = list.name
		previewImage.image = UIImage(named: list.name)
		previewImage.layer.cornerRadius = 15
		palette.layer.cornerRadius = 15
		palette.layer.backgroundColor = UIColor.black.withAlphaComponent(0.35).cgColor
	}

}
