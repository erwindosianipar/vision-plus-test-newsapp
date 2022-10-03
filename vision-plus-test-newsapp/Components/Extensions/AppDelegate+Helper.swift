//
//  AppDelegate+Helper.swift
//  vision-plus-test-newsapp
//
//  Created by Erwindo Sianipar on 03/10/22.
//

import UIKit

extension AppDelegate {
    
    func createWindow() -> UIWindow {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = .systemBackground
        
        guard let window = self.window else {
            return UIWindow(frame: UIScreen.main.bounds)
        }
        
        return window
    }
}
