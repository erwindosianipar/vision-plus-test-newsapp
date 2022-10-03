//
//  HomeCoordinator.swift
//  vision-plus-test-newsapp
//
//  Created by Erwindo Sianipar on 03/10/22.
//

import UIKit

internal final class HomeCoordinator: NavigationCoordinator {
    
    let window: UIWindow
    
    var navigationController: UINavigationController = UINavigationController()
    
    var screenStack: [Screenable] = []
    
    var onCompleted: ((ScreenResult?) -> Void)?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let screens = [
            HomeScreen(())
        ]
        
        set(screens)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func showScreen(identifier: String, navigation: Navigation) {
        if identifier == kHomeScreen {
            switch navigation {
            case .next(let value):
                if let result = value as? NewsResponseModel {
                    push(DetailScreen((result)))
                }
            case .prev:
                pop()
            }
        } else if identifier == kDetailScreen {
            switch navigation {
            case .next:
                return
            case .prev:
                pop()
            }
        }
    }
}
