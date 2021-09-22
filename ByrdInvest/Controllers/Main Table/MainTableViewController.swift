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
	
	lazy var iexManager = IEXAPIManager(apiKey: "token=pk_fb749936d92541fa8d916d36db253dc0")
	var quotes = [Quote]() {
		didSet {
			tableView.reloadData()
		}
	}
	var user = User.getUser()
	var favouriteTickers: [Quote]!
	
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		title = "Main"
		
		getQuotes()
		
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
	
	
	//MARK: - Class Methods
	
	private func getQuotes() {
		guard let tickers = user.favouriteTickers else { return }
		for ticker in tickers {
			iexManager.fetchQuote(ticker: ticker) { (result) in
				switch result {
					case .success(let quote):
						self.quotes.append(quote)
					case .failure(let error):
						let alertController = self.iexManager.alertController(title: "Unable to get data", message: "\(error.localizedDescription)", error: error)
						self.present(alertController, animated: true, completion: nil)
				}
			}
		}

	}


	//MARK: - Table View Data Source
	
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		quotes.count + 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if indexPath.row == 0 {
			guard let cell = tableView.dequeueReusableCell(withIdentifier: headerCellID, for: indexPath) as? HeaderCell else { return UITableViewCell() }
			cell.setup(title: "Favourite")
			return cell
		}
		print("\(quotes[0].companyName)")
		guard let cell = tableView.dequeueReusableCell(withIdentifier: tickerCellID, for: indexPath) as? TickerPreviewCell else { return UITableViewCell() }
		cell.setup(ticker: quotes[indexPath.row - 1])
		return cell
    }
	
	
	//MARK: - Table View Delegate
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		guard indexPath.row > 0 else { return }
		performSegue(withIdentifier: "TickerViewController", sender: indexPath.row - 1)
	}
    
	
	//MARK: - Navigate
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let tickerVC = segue.destination as? TickerViewController {
			guard let index = sender as? Int else { return }
			tickerVC.ticker = quotes[index]
		} else if let listVC = segue.destination as? ListTableViewController {
			guard let index = sender as? Int else { return }
			listVC.listType = lists[index].name.lowercased()
		}
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
