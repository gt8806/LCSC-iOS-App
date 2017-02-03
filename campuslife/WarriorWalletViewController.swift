//
//  WarriorWebViewController.swift
//  LCSC
//
//  Created by Gus Tropea on 2/1/17.
//  Copyright © 2017 LCSC. All rights reserved.
//

import UIKit

class WarriorWalletViewController: UIViewController {
	//This gets the data from the database using the warriorWallet API
	func get_data(key: String)-> (String, Int){
		let session = URLSession.shared
		var email = ""
		var points = 0
		points = 0
		let warriorWalletRequestURL = URL(string: "")!// call to api
		
		let dataTask = session.dataTask(with: warriorWalletRequestURL, completionHandler: {
			(data: Data?, response: URLResponse?, error: Error?) in
			if let error = error {
				print("Error:\n\(error)")
			}
			else {
				do {
					let mydata = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String: AnyObject]
					email = mydata["main"]!["email"]!! as! String
					points = mydata["main"]!["points"]!! as! Int

				}
				catch let jsonError as NSError {
					print("JSON error description: \(jsonError.description)")
				}
			}
		})
		dataTask.resume()
		return(email,points)
	}

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
