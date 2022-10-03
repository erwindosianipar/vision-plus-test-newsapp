//
//  NavigationEvent.swift
//  vision-plus-test-newsapp
//
//  Created by Erwindo Sianipar on 03/10/22.
//

internal enum Navigation {
    case prev(ScreenResult?)
    case next(ScreenResult?)
}

internal final class NavigationEvent {
    
    typealias EventHandler = ((Navigation) -> Void)
    
    var eventHandler: EventHandler?
    
    func send(_ navigation: Navigation) {
        eventHandler?(navigation)
    }
    
    func on(_ handler: @escaping EventHandler) {
        eventHandler = handler
    }
}
