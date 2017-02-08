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
	

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
		//menuButton.target = revealViewController()
		//menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
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
