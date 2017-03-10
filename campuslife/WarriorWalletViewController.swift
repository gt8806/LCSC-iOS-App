//
//  WarriorWalletViewController.swift
//  LCSC
//
//  Created by Janey Valerio on 2/27/17.
//  Copyright © 2017 LCSC. All rights reserved.
//

import UIKit

class WarriorWalletViewController: UIViewController, UIWebViewDelegate {

	@IBOutlet weak var menuButton: UIBarButtonItem!
	
	let defaults = UserDefaults.standard
	
	
	func bttnTouched(_ sender: UIBarButtonItem){
		self.performSegue(withIdentifier: "pointsBackToMenu", sender: nil)
	}
	
	func login_worked(usrname: String, password: String) -> Bool{
		print("place holder")
		return true
	}
	
	
	@IBOutlet weak var walletWebView: UIWebView!
	
	var urlValue = "http://isoptera.lcsc.edu/~jvalerio/"
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		if let url = URL (string: urlValue){
			let requestObj = URLRequest(url: url)
			_ = walletWebView.loadRequest(requestObj)
		}
		
		var userName = ""
		var passWord = ""
		
		if (defaults.string(forKey: "wwlogin") != nil) && (defaults.string(forKey: "wwpassword") != nil){
			userName = defaults.string(forKey: "wwlogin")!
			passWord = defaults.string(forKey: "wwpassword")!
			//this is the case in which a user name and password exist, but they are not correct.
			if login_worked(usrname: userName, password: passWord) == false {
				print("place holder")
			}
			print("Username: "+userName)
			print("password: "+passWord)
		}
		else{
			print("placeholder")
		}

		
		if self.revealViewController() != nil {
			menuButton.target = self.revealViewController()
			menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
			self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
			self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
		}
		
		
		// Do any additional setup after loading the view.
	}
	
	//This gets the data from the database using the warriorWallet API
	func get_points(key: String)-> (Int){
		let session = URLSession.shared
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
					points = mydata["main"]!["points"]!! as! Int
					
				}
				catch let jsonError as NSError {
					print("JSON error description: \(jsonError.description)")
				}
			}
		})
		dataTask.resume()
		return(points)
	}
	
	

	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	

}
