//
//  MapViewController.swift
//  LCSC
//
//  Created by Eric de Baere Grassl on 3/16/16.
//  Copyright © 2016 LCSC. All rights reserved.
//

import UIKit

//map view
class MapViewController: UIViewController {
    @IBOutlet weak var menuButton: UIBarButtonItem!

	
	@IBOutlet weak var lcscMap: UIWebView!

    func bttnTouched(_ sender: UIBarButtonItem){
        self.performSegue(withIdentifier: "mapBackToMenu", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
		let titleImage = UIImage(named: "Wordmark-Blue-Red-1")
		let go: UIButton = UIButton(frame: CGRect(x: 0,y: 0,width: 150, height: 25))
		go.setImage(titleImage, for: UIControlState())
		go.addTarget(self, action: #selector(WebViewContoller.bttnTouched(_:)), for: UIControlEvents.touchUpInside)
		go.imageView?.contentMode = UIViewContentMode.scaleAspectFit;
		self.navigationItem.titleView = go

		//my code :)
        //loads the slide menu function
        menuButton.target = revealViewController()
        menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
		if let url = URL(string: "http://lcsc.college-tour.com/map.php") {
			let request = URLRequest(url: url)
			lcscMap.loadRequest(request)
		}
	}
}
