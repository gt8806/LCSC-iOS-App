//
//  scriptWebView.swift
//  LCSC
//
//  Created by Eric de Baere Grassl on 3/2/16.
//  Copyright © 2016 LCSC. All rights reserved.
//

import UIKit

class ScriptWebView: Authentication{
    
    fileprivate let warriorURL: String = "https://warriorwebss.lcsc.edu/Student/Account/Login?ReturnUrl=%2fStudent%2fPlanning%2fDegreePlans"
    fileprivate let blackboardURL: String = "https://lcsc.blackboard.com/"
	fileprivate let warriorWalletURL: String = "http://isoptera.lcsc.edu/~gus/"
    
    override init() {
        super.init()
    }

    
    func getScript(_ url: String) -> String {
        if url == warriorURL{
            let savedUsername = super.getWarriorWebUsername()
            let savedPassword = super.getWarriorWebPassword()
            if (savedPassword != "" && savedUsername != ""){
                return "var pwd=\"\(savedPassword)\"; var usr=\"\(savedUsername)\"; document.getElementById(\"UserName\").value = usr; document.getElementById(\"Password\").value = pwd;document.getElementsByClassName(\"login-partial-input form\")[0].click()"
            }
        }else if url == blackboardURL{
            let savedUsername = super.getBlackBoardUsername()
            let savedPassword = super.getBlackBoardPassword()
            if (savedPassword != "" && savedUsername != ""){
                return "var pwd=\"\(savedPassword)\"; var usr=\"\(savedUsername)\"; document.getElementById(\"user_id\").value=usr; document.getElementById(\"password\").value=pwd;document.getElementById('entry-login').click();"
            }
		}else if url == warriorWalletURL{
			let savedUsername = super.getWarriorWalletUsername()
			let savedPassword = super.getWarriorWalletPassword()
			if (savedPassword != "" && savedUsername != ""){
				return "var pwd=\"\(savedPassword)\"; var usr=\"\(savedUsername)\"; document.getElementById(\"username\").value = usr; document.getElementById(\"password\").value = pwd;document.getElementById(\"submit\").click();"
			}
		}
		
		return ""
    }
	
}
