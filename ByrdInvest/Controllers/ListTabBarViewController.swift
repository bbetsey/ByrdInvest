//
//  ListTabBarViewController.swift
//  ByrdInvest
//
//  Created by Антон Тропин on 08.09.2021.
//

import UIKit

class ListTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
	//MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		
		switch segue.identifier {
			case "gainers":
				
			case "active":
				<#code#>
			case "loosers":
				<#code#>
			case .none:
				<#code#>
			case .some(_):
				<#code#>
		}
    }
    

}
