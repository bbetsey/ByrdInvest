//
//  ListTableViewController.swift
//  ByrdInvest
//
//  Created by Антон Тропин on 19.09.2021.
//

import UIKit

private let cellID = "TickerPreviewCell"

class ListTableViewController: UITableViewController {
	
	var listType: String!
	var tickers = ListElem.getList()
	

    override func viewDidLoad() {
        super.viewDidLoad()

		title = listType.capitalized
		
		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(UINib(nibName: cellID, bundle: nil), forCellReuseIdentifier: cellID)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		tickers.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? TickerPreviewCell else { return UITableViewCell() }
		cell.setup(ticker: tickers[indexPath.row])
		return cell
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		guard let tickerVC = segue.destination as? TickerViewController else { return }
			guard let index = sender as? Int else { return }
			tickerVC.ticker = tickers[index]
    }
    
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		performSegue(withIdentifier: "TickerViewController", sender: indexPath.row)
	}
}
