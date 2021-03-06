//
//  Authentication.swift
//  LCSC
//
//  Created by Eric de Baere Grassl on 2/29/16.
//  Copyright © 2016 LCSC. All rights reserved.
//

import UIKit


//saves the user username and password
@objc class Authentication: NSObject {
    
    fileprivate var prefs = UserDefaults.standard
	fileprivate let keychain = KeychainSwift()

	override init(){
        super.init()
        //initializing data in case it is nil
		if (((prefs.string(forKey: "walletlogin") == nil || keychain.get("walletpassword") == nil || prefs.string(forKey: "wwlogin") == nil || keychain.get("wwpassword") == nil || prefs.string(forKey: "bblogin") == nil || keychain.get("bbpassword") == nil)) || (prefs.string(forKey: "lcmlogin") == nil) || (keychain.get("lcmpassword")) == nil) {
            clearProfile()
        }
        if (prefs.string(forKey: "userHaveEverBeenAtResourcesPage") == nil){
            prefs.set(false, forKey: "userHaveEverBeenAtResourcesPage")
        }
        if (prefs.string(forKey: "userHaveEverBeenAtProfilePage") == nil){
            prefs.set(false, forKey: "userHaveEverBeenAtProfilePage")
        }
        prefs.synchronize()
    }
    
    func clearProfile(){
        clearWarriorWebProfile()
        clearBlackBoardProfile()
		clearWarriorWalletProfile()
        clearLCMailProfile()
    }
    
    func clearWarriorWebProfile(){
        prefs.set("", forKey: "wwlogin")
		keychain.set("", forKey: "wwpassword")
        prefs.synchronize()
    }
    
    func clearBlackBoardProfile(){
        prefs.set("", forKey: "bblogin")
		keychain.set("", forKey: "bbpassword")
        prefs.synchronize()
    }
	
	func clearWarriorWalletProfile(){
		prefs.set("", forKey: "walletlogin")
		keychain.set("", forKey: "walletpassword")
		prefs.synchronize()
	}
	
    func clearLCMailProfile(){
        prefs.set("", forKey: "lcmlogin")
		keychain.set("", forKey: "lcmpassword")
        prefs.synchronize()
    }
    
    //function to avoid showing the alert in resources table more than once
    func userHaveEverBeenAtResourcesPage() -> Bool{
        let bool = prefs.bool(forKey: "userHaveEverBeenAtResourcesPage")
        return bool
    }
    
    
    func setUserHaveEverBeenAtResourcesPage(_ bool: Bool){
        prefs.set(bool, forKey: "userHaveEverBeenAtResourcesPage")
        prefs.synchronize()
    }
    
    func setUserHaveEverBeenAtProfilePage(_ bool: Bool){
        prefs.set(bool, forKey: "userHaveEverBeenAtProfilePage")
        prefs.synchronize()
    }
    
    func userHaveEverBeenAtProfilePage() -> Bool{
        let bool = prefs.bool(forKey: "userHaveEverBeenAtProfilePage")
        return bool
    }
    
    //save your data acording to the profile destination and returns a bool representing if it was successfull operation or not
    func setProfile(_ destination: String, newLogin: String?, newPassword: String?) -> Bool{
        if destination == "warriorweb"{
            if (newLogin != ""){
                if (newPassword != ""){
                    prefs.set(newLogin!, forKey: "wwlogin")
					keychain.set(newPassword!, forKey: "wwpassword")
                    prefs.synchronize()
                    return true
                }
            }
        }else if destination == "blackboard"{
            if (newLogin != ""){
                if (newPassword != ""){
                    prefs.set(newLogin!, forKey: "bblogin")
					keychain.set(newPassword!, forKey: "bbpassword")
                    prefs.synchronize()
                    return true
                }
            }
        }else if destination == "warriorWallet"{
			if (newLogin != ""){
				if (newPassword != ""){
					prefs.set(newLogin!, forKey: "walletlogin")
					keychain.set(newPassword!, forKey: "walletpassword")
					prefs.synchronize()
					return true
				}
			}
		}
		return false
    }
	
	
    //gets
    func getWarriorWebUsername() -> String{
        return prefs.string(forKey: "wwlogin")!
    }
    
    func getWarriorWebPassword() -> String{
        return keychain.get("wwpassword")!
    }
    
    func getBlackBoardUsername() -> String{
        return prefs.string(forKey: "bblogin")!
    }
    
    func getBlackBoardPassword() -> String{
        return keychain.get("bbpassword")!
    }
	
	func getWarriorWalletUsername() -> String{
		return prefs.string(forKey: "walletlogin")!
	}
	
	func getWarriorWalletPassword() -> String{
		return keychain.get("walletpassword")!
	}
	
}

