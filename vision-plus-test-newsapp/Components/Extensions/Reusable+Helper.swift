//
//  Reusable+Helper.swift
//  vision-plus-test-newsapp
//
//  Created by Erwindo Sianipar on 03/10/22.
//

import UIKit

public protocol Reusable: AnyObject {
    
    static var identifier: String { get }
}

public extension Reusable {
    
    static var identifier: String {
        return String(describing: self)
    }
}
