//
//  ProfileViewController.swift
//  LCSC
//
//  Created by Eric de Baere Grassl on 3/23/16.
//  Copyright © 2016 LCSC. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController,UINavigationControllerDelegate {
	
	
	

	@IBOutlet weak var webView: UIWebView!
	var urlValue = "http://connect.lcsc.edu/ecc/warrioronecard.aspx"
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundCollor")!)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
		
		
		
		if let url = URL (string: urlValue){
			let requestObj = URLRequest(url: url)
			_ = webView.loadRequest(requestObj)
		}
    }
}
