//
//  ListTableViewController.swift
//  ByrdInvest
//
//  Created by Антон Тропин on 19.09.2021.
//

import UIKit

private let cellID = "TickerPreviewCell"

class ListTableViewController: UITableViewController {
	
	lazy var iexManager = IEXAPIManager(apiKey: "token=pk_fb749936d92541fa8d916d36db253dc0")
	var quotes = [Quote]()
	var tickers: [List]? {
		didSet {
			getQuotes()
		}
	}
	var listType: String! {
		didSet {
			getTickers()
			}
	}
	var list: [List]?
	
    override func viewDidLoad() {
        super.viewDidLoad()

		title = listType.capitalized
		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(UINib(nibName: cellID, bundle: nil), forCellReuseIdentifier: cellID)
    }

	private func getTickers() {
		iexManager.fetchList(type: listType) { result in
			switch result {
				case .Success(let list):
					self.tickers = list
					self.tableView.reloadData()
				case .Failure(let error):
					print(error)
			}
		}
	}
	
	private func getQuotes() {
		for ticker in tickers! {
			iexManager.fetchQuote(ticker: ticker.symbol) { result in
				switch result {
					case .Success(let quote):
						self.quotes.append(quote)
						self.tableView.reloadData()
					case .Failure(let error):
						print(error)
				}
			}
			
		}
	}
	
	
    // MARK: - Table View Data Source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		quotes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? TickerPreviewCell else { return UITableViewCell() }
		cell.setup(ticker: quotes[indexPath.row])
		return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		guard let tickerVC = segue.destination as? TickerViewController else { return }
			guard let index = sender as? Int else { return }
			tickerVC.ticker = quotes[index]
    }
    
	
	//MARK: - Table View Delegate
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		performSegue(withIdentifier: "TickerViewController", sender: indexPath.row)
	}
}
