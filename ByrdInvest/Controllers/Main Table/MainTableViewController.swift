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

	
    // MARK: - Table view data source

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
	
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}



//MARK: - CollectionView Delegate

extension MainTableViewController: UICollectionViewDelegate {
	
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
