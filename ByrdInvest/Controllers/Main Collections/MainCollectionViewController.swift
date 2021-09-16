//
//  MainCollectionViewController.swift
//  ByrdInvest
//
//  Created by Антон Тропин on 16.09.2021.
//

import UIKit

private let reuseIdentifier = "Cell"

class MainCollectionViewController: UICollectionViewController {

	@IBOutlet var listLayout: UICollectionViewFlowLayout!
	
	private let listViewID = "StockListsCollectionViewCell"
	private let colors = [
		UIColor.systemPink,
		UIColor.systemBlue,
	]
	
	override func viewDidLoad() {
        super.viewDidLoad()

		collectionView.delegate = self
		collectionView.dataSource = self
		collectionView.register(UINib(nibName: listViewID, bundle: nil), forCellWithReuseIdentifier: listViewID)

    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: listViewID, for: indexPath)
				as? StockListsCollectionViewCell else { return UICollectionViewCell() }
		let color = colors[indexPath.item % colors.count]
		cell.setup(color: color)
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}


extension MainCollectionViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let width: CGFloat = view.frame.width - 20
		let height: CGFloat = view.frame.height / 3
		return CGSize(width: width, height: height)
	}
}
