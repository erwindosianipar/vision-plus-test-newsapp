//
//  AppDelegate.swift
//  vision-plus-test-newsapp
//
//  Created by Erwindo Sianipar on 03/10/22.
//

import UIKit
import SnapKit
import netfox

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        NFX.sharedInstance().start()
        injectionHotReload()
        
        let appCoordinator = AppCoordinator(window: createWindow())
        appCoordinator.start()
        
        return true
    }
    
    func injectionHotReload() {
        #if DEBUG
        Bundle(path: "/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle")?.load()
        #endif
    }
}
