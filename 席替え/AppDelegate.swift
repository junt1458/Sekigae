//
//  AppDelegate.swift
//  席替え
//
//  Created by Tomatsu Junki on 2016/01/30.
//  Copyright © 2016年 Tomatsu Junki. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        //
        // 使用するストーリーボードの設定
        //
        let device = UIDevice.currentDevice()
        var sbName = "Main"
        if device.model.hasPrefix("iPhone") {
            let screenSize = UIScreen.mainScreen().bounds.size
            if screenSize.width <= 480.0 {
                sbName = "iPhone4s"
                AppData.usesize1 = true
            } else {
                AppData.usesize1 = false
            }
        } else if device.model.hasPrefix("iPad") {
            sbName = "iPhone4s"
            AppData.usesize1 = true
        }
        let storyboard = UIStoryboard(name: sbName, bundle: nil)
        if let viewController = storyboard.instantiateInitialViewController() {
            self.window?.rootViewController = viewController
        }
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

