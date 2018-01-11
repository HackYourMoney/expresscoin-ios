//
//  AppDelegate.swift
//  expresscoin
//
//  Created by 이동건 on 2017. 12. 29..
//  Copyright © 2017년 이동건. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        

        AppDelegate().window?.tintColor = UIColor.themeDark
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: MainVC())
        window?.makeKeyAndVisible()
        return true
    }
}

