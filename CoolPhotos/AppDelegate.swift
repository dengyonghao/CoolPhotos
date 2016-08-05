//
//  AppDelegate.swift
//  CoolPhotos
//
//  Created by 邓永豪 on 16/7/29.
//  Copyright © 2016年 DYH. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        initHomePage()
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        
    }

    func applicationDidEnterBackground(application: UIApplication) {
        
    }

    func applicationWillEnterForeground(application: UIApplication) {
        
    }

    func applicationDidBecomeActive(application: UIApplication) {
        
    }

    func applicationWillTerminate(application: UIApplication) {
       
    }

    func initHomePage() {
        let homePage = CPHomePageViewController.init();
        let nav = UINavigationController.init(rootViewController: homePage)
        self.window = UIWindow.init(frame: UIScreen.mainScreen().bounds)
        self.window?.rootViewController?.view.backgroundColor = UIColor.whiteColor()
        self.window?.rootViewController = nav
        self.window?.makeKeyWindow()
    }

}

