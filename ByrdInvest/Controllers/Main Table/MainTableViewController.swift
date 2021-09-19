//
//  MainTableViewController.swift
//  ByrdInvest
//
//  Created by Антон Тропин on 17.09.2021.
//

import UIKit

private let listsCellID = "ListsCollectionViewCell"
private let tickerCellID = "TickerPreviewCell"
private let headerCellID = "HeaderCell"

class MainTableViewController: UITableViewController {

	@IBOutlet var listsCollectionView: UICollectionView!
	@IBOutlet var listsCollectionLayout: UICollectionViewFlowLayout!

	let lists = ListPreview.getListsPreview()
	let tickers = ListElem.getList()
	var selectId: Int = 0
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		title = "Main"

		// CollectionView Setup
		listsCollectionView.delegate = self
		listsCollectionView.dataSource = self
		listsCollectionView.register(UINib(nibName: listsCellID, bundle: nil), forCellWithReuseIdentifier: listsCellID)
		
		// TableView Setup
		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(UINib(nibName: tickerCellID, bundle: nil), forCellReuseIdentifier: tickerCellID)
		tableView.register(UINib(nibName: headerCellID, bundle: nil), forCellReuseIdentifier: headerCellID)
		tableView.rowHeight = UITableView.automaticDimension
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		tickers.count + 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if indexPath.row == 0 {
			guard let cell = tableView.dequeueReusableCell(withIdentifier: headerCellID, for: indexPath) as? HeaderCell else { return UITableViewCell() }
			cell.setup(title: "Popular")
			return cell
		}
		
		guard let cell = tableView.dequeueReusableCell(withIdentifier: tickerCellID, for: indexPath) as? TickerPreviewCell else { return UITableViewCell() }
		cell.setup(ticker: tickers[indexPath.row - 1])
		return cell
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let tickerVC = segue.destination as? TickerViewController {
			guard let index = sender as? Int else { return }
			tickerVC.ticker = tickers[index]
		} else if let listVC = segue.destination as? ListTableViewController {
			guard let index = sender as? Int else { return }
			listVC.listType = lists[index].name
		}
    }
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		guard indexPath.row > 0 else { return }
		performSegue(withIdentifier: "TickerViewController", sender: indexPath.row - 1)
	}
    

}



//MARK: - CollectionView Delegate

extension MainTableViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		performSegue(withIdentifier: "ListTableViewController", sender: indexPath.row)
	}
}


//MARK: - CollectionView DataSource

extension MainTableViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		lists.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: listsCellID, for: indexPath) as? ListsCollectionViewCell else { return UICollectionViewCell() }
		cell.setup(list: lists[indexPath.row])
		return cell
	}
	
	
}


//MARK: - CollectionView FlowLayout

extension MainTableViewController: UICollectionViewDelegateFlowLayout {

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		CGSize(width: 220, height: 175)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		8
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		16
	}
}
