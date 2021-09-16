//
//  ListsTableViewCell.swift
//  ByrdInvest
//
//  Created by Антон Тропин on 16.09.2021.
//

import UIKit

private let cellId = "ListPreviewCell"

class ListsTableViewCell: UITableViewCell {

	@IBOutlet var collectionLabel: UILabel!
	@IBOutlet var listsCollection: UICollectionView!
	@IBOutlet var listCollectionLayout: UICollectionViewFlowLayout!
	
	override func awakeFromNib() {
        super.awakeFromNib()
        
		listsCollection.delegate = self
		listsCollection.dataSource = self
		listsCollection.register(UINib(nibName: cellId, bundle: nil), forCellWithReuseIdentifier: cellId)
		collectionLabel.text = "Lists"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


//MARK: - Collection View Delegate

extension ListsTableViewCell: UICollectionViewDelegate {
	
}


//MARK: - Collection View Data Source

extension ListsTableViewCell: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		9
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? ListPreviewCell else { return UICollectionViewCell() }
		
		cell.image = UIImage(named: "MSFT")
		cell.name = "Gainers"
		
		return cell
	}
	
	
}


//MARK: - Collection View Delegate Flow Layout

extension ListsTableViewCell: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		CGSize(width: 200, height: 135)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		16
	}
}
