//
//  LoadingAnimations.swift
//  OpratelCodeChallenge
//
//  Created by alvaro sebastian leon romero on 4/8/16.
//  Copyright © 2016 seblerom. All rights reserved.
//

import UIKit
import MBProgressHUD

class LoadingAnimations: NSObject {

   class func showProgressHUD(view:UIView) {
        let hud = MBProgressHUD.showHUDAddedTo(view, animated: true)
        hud.labelText = "Loading"
    }
    
    class func hideProgressHUD(view:UIView) {
        MBProgressHUD.hideAllHUDsForView(view, animated: true)
    }
    
}
