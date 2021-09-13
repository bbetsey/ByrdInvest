//
//  ListViewController.swift
//  ByrdInvest
//
//  Created by Антон Тропин on 08.09.2021.
//

import UIKit

class ListViewController: UITableViewController {
	
	var list: [ListElem] = []
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		tableView.refreshControl = UIRefreshControl()
		tableView.refreshControl?.attributedTitle = NSAttributedString(string: "Update...")

		tableView.refreshControl?.addTarget(self, action: #selector(updateData), for: .valueChanged)
		
		let nib = UINib(nibName: "TickerPreviewCell", bundle: nil)
		tableView.register(nib, forCellReuseIdentifier: "tickerPreviewCell")
		
		updateData()
		title = "Gainers"
    }
	
	@objc private func updateData() {
		let dataManager = IEXDataManager()
		dataManager.getList(for: "mostactive") { list in
			DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
				self.list = list
				self.tableView.reloadData()
				self.refreshControl?.endRefreshing()
			}
		}
	}

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		list.count
    }

	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		70
	}
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tickerPreviewCell", for: indexPath) as! TickerPreviewCell
		guard !self.list.isEmpty else { return cell }
		
		let company = list[indexPath.row]
		cell.nameLabel.text = company.companyName
		cell.tickerLabel.text = company.symbol
		cell.priceLabel.text = "$\(company.latestPrice)"
		cell.changeLabel.text = "%\(abs(company.priceChange))"
//		cell.accessoryType = .disclosureIndicator
		
		if let image = UIImage(named: company.symbol) {
			cell.logo.image = image
		} else {
			cell.logo.image = UIImage(named: "MOON")
		}
		
		cell.changeLabel.textColor =
			company.priceChange < 0
			? .red
			: .systemGreen
		
        return cell
    }
	
	
	override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		let action = UIContextualAction(style: .normal, title: "Favourite") { _, _, completion in
			tableView.reloadRows(at: [indexPath], with: .automatic)
			completion(true)
		}
		return UISwipeActionsConfiguration(actions: [action])
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
	}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

