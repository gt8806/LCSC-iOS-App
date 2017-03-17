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
	
	var urlValue = "http://isoptera.lcsc.edu:5199"
	
	override func viewDidLoad() {
		super.viewDidLoad()
		walletWebView.scalesPageToFit = true
		if let url = URL (string: urlValue){
			let requestObj = URLRequest(url: url)
			_ = walletWebView.loadRequest(requestObj)
		}
		
		let titleImage = UIImage(named: "Wordmark-Blue-Red-1")
		let go: UIButton = UIButton(frame: CGRect(x: 0,y: 0,width: 150, height: 25))
		go.setImage(titleImage, for: UIControlState())
		go.addTarget(self, action: #selector(WebViewContoller.bttnTouched(_:)), for: UIControlEvents.touchUpInside)
		go.imageView?.contentMode = UIViewContentMode.scaleAspectFit;
		self.navigationItem.titleView = go
		
		
		
		if self.revealViewController() != nil {
			menuButton.target = self.revealViewController()
			menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
			self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
			self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
		}
		
		
		// Do any additional setup after loading the view.
	}
	

	
	

	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	

}
