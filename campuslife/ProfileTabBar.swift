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
		
		let titleImage = UIImage(named: "Wordmark-Blue-Red-1")
		let go: UIButton = UIButton(frame: CGRect(x: 0,y: 0, width: 150, height: 25))
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
		
		
	
	}
	


}
