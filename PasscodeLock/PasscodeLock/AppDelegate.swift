//
//  AppDelegate.swift
//  PasscodeLock
//
//  Created by Oleg Ryasnoy on 18.04.17.
//  Copyright © 2017 Oleg Ryasnoy. All rights reserved.
//

import UIKit
import SwiftUI
import AppLocker

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let root = UIHostingController(rootView: TestView())
        let bounds = UIScreen.main.bounds
        self.window = UIWindow(frame: bounds)
        self.window?.rootViewController = root
        self.window?.makeKeyAndVisible()
        return true
    }
    
}

