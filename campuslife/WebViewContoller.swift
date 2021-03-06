//
//  WebViewContoller.swift
//  LCSC
//
//  Created by Eric de Baere Grassl on 4/18/16.
//  Copyright © 2016 LCSC. All rights reserved.
//

import UIKit


//This class is responsible for the webView used to some of the itens in the menu
class WebViewContoller: UIViewController, UIWebViewDelegate {
	
	fileprivate var prefs = UserDefaults.standard
	fileprivate let keychain = KeychainSwift()
	
	@IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var webViewWindow: UIWebView!

	@IBOutlet weak var QRButton: UIBarButtonItem!
	
    //Load the main Apps's main page when this button is touched
    func bttnTouched(_ sender: UIBarButtonItem){
        self.performSegue(withIdentifier: "backToMenu", sender: nil)
    }
    
    
    //opens an App's with an deeplink as paramenter
    func openAppDeepLink(_ deepLinkString: String){
        let appURL = URL(string: deepLinkString)
        if UIApplication.shared.canOpenURL(appURL!){
            UIApplication.shared.openURL(appURL!)
        } else {
            UIApplication.shared.openURL(URL(string: "https://itunes.apple.com/us/app/gmail-email-from-google/id422689480?mt=8")!)
        }
    }
	
	
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let titleImage = UIImage(named: "Wordmark-Blue-Red-1")
        let go: UIButton = UIButton(frame: CGRect(x: 0,y: 0,width: 150, height: 25))
        go.setImage(titleImage, for: UIControlState())
        go.addTarget(self, action: #selector(WebViewContoller.bttnTouched(_:)), for: UIControlEvents.touchUpInside)
        go.imageView?.contentMode = UIViewContentMode.scaleAspectFit;
        self.navigationItem.titleView = go
        //menu button, tap and pan gestures functionalities
        menuButton.target = revealViewController()
        menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        //opens apps or an URL according to the view's tittle
        var urlText = ""
        let title = self.navigationController!.title!
        switch title{
            case "LCSC": urlText = "http://www.lcsc.edu"
            case "Hangouts": urlText = "https://hangouts.google.com"
            case "Athletics": urlText = "http://www.lcwarriors.com"
            case "WarriorWeb": urlText = "https://warriorwebss.lcsc.edu/Student/Account/Login?ReturnUrl=%2fStudent%2fPlanning%2fDegreePlans"
            case "LCMail": openAppDeepLink("googlegmail://")
            case "BlackBoard": urlText = "https://lcsc.blackboard.com/"
            case "Twitter": urlText = "http://twitter.com/LCSC"
            case "LiveStream": urlText = "http://livestream.com/accounts/8399277"
            case "Facebook": urlText = "https://www.facebook.com/LewisClarkState"
            case "Instagram": urlText = "https://www.instagram.com/lewisclarkstate/?hl=en"
            case "WarriorOne Card": urlText = "http://connect.lcsc.edu/ecc/warrioronecard.aspx"
            case "Campus News": urlText = "http://www.lcsc.edu/news"
			case "WarriorWallet": urlText = "https://isoptera.lcsc.edu:5196"
			//5196
            default: return
        }
		
		if title != ""{
			self.navigationItem.rightBarButtonItem = nil
		}
		
		
		
		func displayLoginAlert() {
			let alert = UIAlertController(title:"Registration successful", message:"You may now login. Thank You!",preferredStyle: UIAlertControllerStyle.alert)
			let loginAction = UIAlertAction(title:"Login", style:UIAlertActionStyle.default) { (UIAlertAction) -> Void in
				self.performSegue(withIdentifier: "walletToProfile", sender:self)

			}
			
			alert.addAction(loginAction)
			self.present(alert, animated: true, completion: nil)
		}

		if title == "WarriorWallet"{
			print(prefs.string(forKey: "walletlogin")!)
			print(keychain.get("walletpassword")!)
			if (prefs.string(forKey: "walletlogin") == nil) ||
				(keychain.get("walletpassword") == nil) {
				print("hello")
				displayLoginAlert()
			}
		}
		
		webViewWindow.scalesPageToFit = true
		
		
        
        //opens URL in webview
        webViewWindow?.delegate = self
        let url = URL(string: urlText)
        let request = URLRequest(url: url!)
        webViewWindow?.loadRequest(request)
        //returns the app to the home view in case the operation called is "Hangouts" or "LCMail"
       if title == "Hangouts" || title == "LCMail"{
            performSegue(withIdentifier: "backToMenu", sender: self)
        }
    }
    
    
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        //runs an script according to the url
        let script = ScriptWebView()
        let currentURL = (webView.request?.url!.absoluteString)!
		print(currentURL)
        webView.stringByEvaluatingJavaScript(from: script.getScript(currentURL))
    }
}
