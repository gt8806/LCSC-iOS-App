//
//  ProfileTabBar.swift
//  LCSC
//
//  Created by Janey Valerio on 2/17/17.
//  Copyright © 2017 LCSC. All rights reserved.
//

import UIKit

class ProfileTabBar: UITabBarController {

	@IBOutlet weak var menuButton: UIBarButtonItem!

	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	func bttnTouched(_ sender: UIBarButtonItem){
		self.performSegue(withIdentifier: "profileBackToMenu", sender: nil)
	}
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		if self.revealViewController() != nil {
			menuButton.target = self.revealViewController()
			menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
			self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
			self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
		}
		
		
	
	}
	


}
