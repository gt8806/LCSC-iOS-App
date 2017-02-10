//
//  WarriorWallet.swift
//  LCSC
//
//  Created by Janey Valerio on 2/8/17.
//  Copyright © 2017 LCSC. All rights reserved.
//

import UIKit

class WarriorWallet: UITabBarController {

	@IBOutlet weak var menuButton: UIBarButtonItem!
	
	func bttnTouched(_ sender: UIBarButtonItem){
		self.performSegue(withIdentifier: "pointsBackToMenu", sender: nil)
	}
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		if self.revealViewController() != nil {
			menuButton.target = self.revealViewController()
			menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
			self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
			self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
		}


        // Do any additional setup after loading the view.
    }
	
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
